/* Copyright (c) 2019-2022 Hans-Kristian Arntzen for Valve Corporation
 *
 * SPDX-License-Identifier: MIT
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "opcodes/opcodes.hpp"
#include "dxil_common.hpp"
#include "opcodes/converter_impl.hpp"
#include "spirv_module.hpp"
#include "logging.hpp"

namespace dxil_spv
{
spv::Id emit_temp_storage_copy(Converter::Impl &impl, const llvm::Value *value, spv::StorageClass storage)
{
	// Make a new temporary variable for the ray payload/callable data.
	auto *pointer_type = llvm::cast<llvm::PointerType>(value->getType());
	auto *pointee_type = pointer_type->getPointerElementType();
	spv::Id type_id = impl.get_type_id(pointee_type);
	spv::Id var_id = impl.get_temp_payload(type_id, storage);

	// Load the alloca'ed value
	auto *load_op = impl.allocate(spv::OpLoad, type_id);
	load_op->add_id(impl.get_id_for_value(value));
	impl.add(load_op);

	// Store the alloca'ed value to our data in the right storage type
	auto *store_op = impl.allocate(spv::OpStore);
	store_op->add_id(var_id);
	store_op->add_id(load_op->id);
	impl.add(store_op);

	return var_id;
}

void emit_temp_storage_resolve(Converter::Impl &impl, const llvm::Value *real_value, spv::Id temp_storage)
{
	auto *pointer_type = llvm::cast<llvm::PointerType>(real_value->getType());
	auto *pointee_type = pointer_type->getPointerElementType();
	spv::Id type_id = impl.get_type_id(pointee_type);

	// Load the result from the temp
	auto *load_op = impl.allocate(spv::OpLoad, type_id);
	load_op->add_id(temp_storage);
	impl.add(load_op);

	// Store the result in the alloca'ed value
	auto *store_op = impl.allocate(spv::OpStore);
	store_op->add_id(impl.get_id_for_value(real_value));
	store_op->add_id(load_op->id);
	impl.add(store_op);
}

bool emit_trace_ray_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	if (emit_nvapi_trace_ray(impl, inst))
		return true;

	auto &builder = impl.builder();
	spv::Id acceleration_structure = impl.get_id_for_value(inst->getOperand(1));
	spv::Id ray_flags = impl.build_ray_flags_without_unsupported_omm(inst->getOperand(2), impl.options.opacity_micromap_enabled);
	spv::Id instance_inclusion_mask = impl.get_id_for_value(inst->getOperand(3));
	spv::Id ray_contribution_to_hit_group = impl.get_id_for_value(inst->getOperand(4));
	spv::Id multiplier_for_geometry = impl.get_id_for_value(inst->getOperand(5));
	spv::Id miss_shader_index = impl.get_id_for_value(inst->getOperand(6));

	spv::Id ray_origin[3];
	spv::Id ray_dir[3];

	for (unsigned i = 0; i < 3; i++)
	{
		ray_origin[i] = impl.get_id_for_value(inst->getOperand(7 + i));
		ray_dir[i] = impl.get_id_for_value(inst->getOperand(11 + i));
	}

	spv::Id tmin = impl.get_id_for_value(inst->getOperand(10));
	spv::Id tmax = impl.get_id_for_value(inst->getOperand(14));

	spv::Id ray_origin_vec = impl.build_vector(builder.makeFloatType(32), ray_origin, 3);
	spv::Id ray_dir_vec = impl.build_vector(builder.makeFloatType(32), ray_dir, 3);

	auto *ray_payload = inst->getOperand(15);

	bool needs_temp_copy = impl.get_needs_temp_storage_copy(ray_payload);
	spv::Id ray_payload_var_id = needs_temp_copy
		? emit_temp_storage_copy(impl, ray_payload, spv::StorageClassRayPayloadKHR)
		: impl.get_id_for_value(ray_payload);

	auto *op = impl.allocate(spv::OpTraceRayKHR);
	op->add_ids({
	    acceleration_structure,
	    ray_flags,
	    instance_inclusion_mask,
	    ray_contribution_to_hit_group,
	    multiplier_for_geometry,
	    miss_shader_index,
	    ray_origin_vec,
	    tmin,
	    ray_dir_vec,
	    tmax,
	    ray_payload_var_id
	});
	impl.add(op);

	// In this instance, the ray_payload_var_id is our temp.
	if (needs_temp_copy)
		emit_temp_storage_resolve(impl, ray_payload, ray_payload_var_id);

	return true;
}

bool emit_ray_tracing_builtin_load_instruction(Converter::Impl &impl, const llvm::CallInst *inst,
                                               spv::BuiltIn builtin, spv::Id scalar_type)
{
	auto &builder = impl.builder();
	spv::Id input = impl.spirv_module.get_builtin_shader_input(builtin);

	auto *access_chain = impl.allocate(spv::OpAccessChain, builder.makePointer(spv::StorageClassInput, scalar_type));
	access_chain->add_id(input);
	access_chain->add_id(impl.get_id_for_value(inst->getOperand(1), 32));
	impl.add(access_chain);

	auto *load = impl.allocate(spv::OpLoad, inst);
	load->add_id(access_chain->id);
	impl.add(load);
	return true;
}

bool emit_dispatch_rays_index_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_builtin_load_instruction(impl, inst, spv::BuiltInLaunchIdKHR,
	                                                 impl.builder().makeUintType(32));
}

bool emit_dispatch_rays_dimensions_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_builtin_load_instruction(impl, inst, spv::BuiltInLaunchSizeKHR,
	                                                 impl.builder().makeUintType(32));
}

bool emit_object_ray_origin_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_builtin_load_instruction(impl, inst, spv::BuiltInObjectRayOriginKHR,
	                                                 impl.builder().makeFloatType(32));
}

bool emit_world_ray_origin_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_builtin_load_instruction(impl, inst, spv::BuiltInWorldRayOriginKHR,
	                                                 impl.builder().makeFloatType(32));
}

bool emit_object_ray_direction_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_builtin_load_instruction(impl, inst, spv::BuiltInObjectRayDirectionKHR,
	                                                 impl.builder().makeFloatType(32));
}

bool emit_world_ray_direction_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_builtin_load_instruction(impl, inst, spv::BuiltInWorldRayDirectionKHR,
	                                                 impl.builder().makeFloatType(32));
}

bool emit_ray_t_min_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	spv::Id id = impl.spirv_module.get_builtin_shader_input(spv::BuiltInRayTminKHR);
	auto *op = impl.allocate(spv::OpLoad, inst);
	op->add_id(id);
	impl.add(op);
	return true;
}

bool emit_ray_t_current_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	spv::Id id = impl.spirv_module.get_builtin_shader_input(spv::BuiltInRayTmaxKHR);
	auto *op = impl.allocate(spv::OpLoad, inst);
	op->add_id(id);

	if (impl.execution_mode_meta.memory_model == spv::MemoryModelVulkan &&
	    impl.spirv_module.builtin_requires_volatile(spv::BuiltInRayTmaxKHR))
	{
		op->add_literal(spv::MemoryAccessVolatileMask);
	}

	impl.add(op);
	return true;
}

static bool emit_ray_tracing_matrix_load(Converter::Impl &impl, const llvm::CallInst *inst, spv::BuiltIn builtin)
{
	auto &builder = impl.builder();
	spv::Id matrix_id = impl.spirv_module.get_builtin_shader_input(builtin);
	auto *chain_op = impl.allocate(spv::OpAccessChain, builder.makePointer(spv::StorageClassInput, builder.makeFloatType(32)));
	chain_op->add_id(matrix_id);

	// Transpose here.
	chain_op->add_id(impl.get_id_for_value(inst->getOperand(2), 32));
	chain_op->add_id(impl.get_id_for_value(inst->getOperand(1)));

	impl.add(chain_op);

	auto *load_op = impl.allocate(spv::OpLoad, inst);
	load_op->add_id(chain_op->id);
	impl.add(load_op);
	return true;
}

bool emit_ray_tracing_report_hit(Converter::Impl &impl, const llvm::CallInst *inst)
{
	// We only have one global HitAttributeKHR per shader, so we'll need to copy from argument into that.
	auto *load_op = impl.allocate(spv::OpLoad, impl.get_type_id(impl.llvm_hit_attribute_output_type->getPointerElementType()));
	load_op->add_id(impl.get_id_for_value(inst->getOperand(3)));
	impl.add(load_op);

	auto *store_op = impl.allocate(spv::OpStore);
	store_op->add_id(impl.llvm_hit_attribute_output_value);
	store_op->add_id(load_op->id);
	impl.add(store_op);

	auto *op = impl.allocate(spv::OpReportIntersectionKHR, inst);
	op->add_id(impl.get_id_for_value(inst->getOperand(1)));
	op->add_id(impl.get_id_for_value(inst->getOperand(2)));
	impl.add(op);
	return true;
}

bool emit_ray_tracing_accept_hit_and_end_search(Converter::Impl &impl, const llvm::CallInst *)
{
	auto *op = impl.allocate(spv::OpTerminateRayKHR);
	impl.add(op);
	return true;
}

bool emit_ray_tracing_ignore_hit(Converter::Impl &impl, const llvm::CallInst *)
{
	auto *op = impl.allocate(spv::OpIgnoreIntersectionKHR);
	impl.add(op);
	return true;
}

bool emit_ray_tracing_call_shader(Converter::Impl &impl, const llvm::CallInst *inst)
{
	if (emit_nvapi_call_shader(impl, inst))
		return true;

	auto *callable_data = inst->getOperand(2);

	bool needs_temp_copy = impl.get_needs_temp_storage_copy(callable_data);
	spv::Id callable_data_var_id = impl.get_needs_temp_storage_copy(callable_data)
		? emit_temp_storage_copy(impl, callable_data, spv::StorageClassCallableDataKHR)
		: impl.get_id_for_value(callable_data);

	auto *op = impl.allocate(spv::OpExecuteCallableKHR);
	op->add_id(impl.get_id_for_value(inst->getOperand(1)));
	op->add_id(callable_data_var_id);
	impl.add(op);

	// In this instance, the callable_data_var_id is our temp.
	if (needs_temp_copy)
		emit_temp_storage_resolve(impl, callable_data, callable_data_var_id);

	return true;
}

bool emit_world_to_object_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_matrix_load(impl, inst, spv::BuiltInWorldToObjectKHR);
}

bool emit_object_to_world_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_matrix_load(impl, inst, spv::BuiltInObjectToWorldKHR);
}

static bool emit_ray_tracing_load_uint(Converter::Impl &impl, const llvm::CallInst *inst, spv::BuiltIn builtin)
{
	spv::Id index_id = impl.spirv_module.get_builtin_shader_input(builtin);
	auto *op = impl.allocate(spv::OpLoad, inst);
	op->add_id(index_id);
	impl.add(op);
	return true;
}

bool emit_ray_tracing_instance_id_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_load_uint(impl, inst, spv::BuiltInInstanceCustomIndexKHR);
}

bool emit_ray_tracing_instance_index_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_load_uint(impl, inst, spv::BuiltInInstanceId);
}

bool emit_ray_tracing_geometry_index_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_load_uint(impl, inst, spv::BuiltInRayGeometryIndexKHR);
}

bool emit_ray_tracing_primitive_index_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_load_uint(impl, inst, spv::BuiltInPrimitiveId);
}

bool emit_ray_tracing_ray_flags_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_load_uint(impl, inst, spv::BuiltInIncomingRayFlagsKHR);
}

bool emit_ray_tracing_hit_kind_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	return emit_ray_tracing_load_uint(impl, inst, spv::BuiltInHitKindKHR);
}

bool emit_allocate_ray_query(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	if (impl.ray_query.global_query_objects_id)
	{
		uint32_t index;
		if (impl.shader_analysis.ray_query.uses_divergent_handles)
			index = impl.ray_query.ray_query_index++;
		else
			index = 0;

		impl.rewrite_value(inst, builder.makeUintConstant(index));
	}
	else
	{
		spv::Id var_id = impl.spirv_module.create_variable(spv::StorageClassPrivate, builder.makeRayQueryType());
		impl.rewrite_value(inst, var_id);
		impl.handle_to_storage_class[inst] = spv::StorageClassPrivate;
	}

	return true;
}

static bool get_representative_ray_query_flags(Converter::Impl &impl, const llvm::Value *operand,
                                               uint32_t &ray_query_flags)
{
	if (value_is_dx_op_instrinsic(operand, DXIL::Op::AllocateRayQuery) ||
		value_is_dx_op_instrinsic(operand, DXIL::Op::AllocateRayQuery2))
	{
		return get_constant_operand(llvm::cast<llvm::CallInst>(operand), 1, &ray_query_flags);
	}
	else if (const auto *phi = llvm::dyn_cast<llvm::PHINode>(operand))
	{
		// HLSL expectation is that all ray query flags are the same, so pick the static flags from first incoming.
		return get_representative_ray_query_flags(impl, phi->getIncomingValue(0), ray_query_flags);
	}
	else if (const auto *select = llvm::dyn_cast<llvm::SelectInst>(operand))
	{
		return get_representative_ray_query_flags(impl, select->getOperand(1), ray_query_flags);
	}
	else if (const auto *load = llvm::dyn_cast<llvm::LoadInst>(operand))
	{
		return get_representative_ray_query_flags(impl, load->getPointerOperand(), ray_query_flags);
	}
	else if (const auto *gep = llvm::dyn_cast<llvm::GetElementPtrInst>(operand))
	{
		return get_representative_ray_query_flags(impl, gep->getOperand(0), ray_query_flags);
	}
	else if (const auto *alloca = llvm::dyn_cast<llvm::AllocaInst>(operand))
	{
		for (auto &mapping : impl.shader_analysis.ray_query.alloca_mappings)
		{
			if (mapping.alloca == alloca)
			{
				ray_query_flags = mapping.ray_query_flags;
				return true;
			}
		}

		LOGE("Cannot find ray query flags mapping.\n");
		return false;
	}

	// No idea ...
	LOGE("Cannot find representative ray query flags.\n");
	return false;
}

bool build_ray_query_object(Converter::Impl &impl, const llvm::Value *operand,
                            spv::Id &object_id, uint32_t *ray_query_flags = nullptr)
{
	if (impl.ray_query.global_query_objects_id)
	{
		auto &builder = impl.builder();

		if (impl.shader_analysis.ray_query.uses_divergent_handles)
		{
			// Painful case.
			auto *chain = impl.allocate(spv::OpInBoundsAccessChain,
			                            builder.makePointer(spv::StorageClassPrivate, builder.makeRayQueryType()));
			chain->add_id(impl.ray_query.global_query_objects_id);
			chain->add_id(impl.get_id_for_value(operand));
			impl.add(chain);

			object_id = chain->id;
		}
		else
		{
			// Trivial case.
			object_id = impl.ray_query.global_query_objects_id;
		}

		// Need to deduce the flags for the allocation.
		// This must be statically deducible from an HLSL point of view.
		// If we fail this check, fail compilation.
		if (ray_query_flags && !get_representative_ray_query_flags(impl, operand, *ray_query_flags))
			return false;
	}
	else
	{
		object_id = impl.get_id_for_value(operand);
		auto *ray_object = llvm::cast<llvm::CallInst>(operand);
		if (ray_query_flags && !get_constant_operand(ray_object, 1, ray_query_flags))
			return false;
	}

	return true;
}

bool emit_ray_query_trace_ray_inline_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	auto &builder = impl.builder();
	auto *init_op = impl.allocate(spv::OpRayQueryInitializeKHR);

	spv::Id ray_object_id = 0;
	uint32_t ray_query_flags = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id, &ray_query_flags))
		return false;

	init_op->add_id(ray_object_id);
	init_op->add_id(impl.get_id_for_value(instruction->getOperand(2)));

	// The template type of the ray query object is embedded in the object itself, we must OR in the constant flags.
	if (auto *const_flags = llvm::dyn_cast<llvm::ConstantInt>(instruction->getOperand(3)))
	{
		ray_query_flags |= const_flags->getUniqueInteger().getZExtValue();
		if (!impl.ray_query_opacity_micromap_enabled())
			ray_query_flags &= ~uint32_t(spv::RayFlagsForceOpacityMicromap2StateKHRMask);
		init_op->add_id(builder.makeUintConstant(ray_query_flags));
	}
	else if (ray_query_flags == 0)
	{
		init_op->add_id(impl.get_id_for_value(instruction->getOperand(3)));
	}
	else
	{
		auto *or_op = impl.allocate(spv::OpBitwiseOr, builder.makeUintType(32));
		or_op->add_id(impl.get_id_for_value(instruction->getOperand(3)));
		or_op->add_id(builder.makeUintConstant(ray_query_flags));
		impl.add(or_op);
		init_op->add_id(or_op->id);
	}

	init_op->add_id(impl.get_id_for_value(instruction->getOperand(4)));

	spv::Id origin[3], direction[3];
	for (unsigned i = 0; i < 3; i++)
	{
		origin[i] = impl.get_id_for_value(instruction->getOperand(5 + i));
		direction[i] = impl.get_id_for_value(instruction->getOperand(9 + i));
	}
	init_op->add_id(impl.build_vector(builder.makeFloatType(32), origin, 3));
	init_op->add_id(impl.get_id_for_value(instruction->getOperand(8)));
	init_op->add_id(impl.build_vector(builder.makeFloatType(32), direction, 3));
	init_op->add_id(impl.get_id_for_value(instruction->getOperand(12)));

	impl.add(init_op);

	return true;
}

bool emit_ray_query_proceed_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(spv::OpRayQueryProceedKHR, instruction);
	op->add_id(ray_object_id);
	impl.add(op);
	return true;
}

bool emit_ray_query_abort_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(spv::OpRayQueryTerminateKHR);
	op->add_id(ray_object_id);
	impl.add(op);
	return true;
}

bool emit_ray_query_intersection_type_instruction(Converter::Impl &impl, const llvm::CallInst *instruction,
                                                  spv::RayQueryIntersection intersection)
{
	auto &builder = impl.builder();
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(spv::OpRayQueryGetIntersectionTypeKHR, instruction);
	op->add_id(ray_object_id);
	op->add_id(builder.makeUintConstant(intersection));
	impl.add(op);
	return true;
}

bool emit_ray_query_system_value_instruction(Converter::Impl &impl, const llvm::CallInst *instruction,
                                             spv::Op opcode, uint32_t vecsize)
{
	auto &builder = impl.builder();
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	if (vecsize == 1)
	{
		auto *op = impl.allocate(opcode, instruction);
		op->add_id(ray_object_id);
		impl.add(op);
	}
	else
	{
		auto *op = impl.allocate(opcode, builder.makeVectorType(impl.get_type_id(instruction->getType()), vecsize));
		op->add_id(ray_object_id);
		impl.add(op);
		auto *extract_op = impl.allocate(spv::OpCompositeExtract, instruction);
		extract_op->add_id(op->id);

		uint32_t index = 0;
		if (!get_constant_operand(instruction, 2, &index))
			return false;
		extract_op->add_literal(index);
		impl.add(extract_op);
	}
	return true;
}

bool emit_ray_query_get_value_instruction(Converter::Impl &impl, const llvm::CallInst *instruction,
                                          spv::Op opcode, uint32_t vecsize, spv::RayQueryIntersection intersection)
{
	auto &builder = impl.builder();
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	if (vecsize == 1)
	{
		auto *op = impl.allocate(opcode, instruction);
		op->add_id(ray_object_id);
		op->add_id(builder.makeUintConstant(intersection));
		impl.add(op);
	}
	else
	{
		auto *op = impl.allocate(opcode, builder.makeVectorType(impl.get_type_id(instruction->getType()), vecsize));
		op->add_id(ray_object_id);
		op->add_id(builder.makeUintConstant(intersection));
		impl.add(op);
		auto *extract_op = impl.allocate(spv::OpCompositeExtract, instruction);
		extract_op->add_id(op->id);

		uint32_t index = 0;
		if (!get_constant_operand(instruction, 2, &index))
			return false;
		extract_op->add_literal(index);
		impl.add(extract_op);
	}
	return true;
}

bool emit_ray_query_get_matrix_value_instruction(Converter::Impl &impl, const llvm::CallInst *instruction,
                                                 spv::Op opcode, spv::RayQueryIntersection intersection)
{
	auto &builder = impl.builder();
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(opcode, builder.makeMatrixType(impl.get_type_id(instruction->getType()), 4, 3));
	op->add_id(ray_object_id);
	op->add_id(builder.makeUintConstant(intersection));
	impl.add(op);

	auto *extract_op = impl.allocate(spv::OpCompositeExtract, instruction);
	uint32_t row = 0, col = 0;
	if (!get_constant_operand(instruction, 2, &row))
		return false;
	if (!get_constant_operand(instruction, 3, &col))
		return false;
	extract_op->add_id(op->id);
	extract_op->add_literal(col);
	extract_op->add_literal(row);
	impl.add(extract_op);
	return true;
}

bool emit_ray_query_commit_non_opaque_triangle_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(spv::OpRayQueryConfirmIntersectionKHR);
	op->add_id(ray_object_id);
	impl.add(op);
	return true;
}

bool emit_ray_query_commit_procedural_primitive_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(spv::OpRayQueryGenerateIntersectionKHR);
	op->add_id(ray_object_id);
	op->add_id(impl.get_id_for_value(instruction->getOperand(2)));
	impl.add(op);
	return true;
}

bool emit_ray_query_candidate_procedural_primitive_non_opaque_instruction(Converter::Impl &impl,
                                                                          const llvm::CallInst *instruction)
{
	auto &builder = impl.builder();
	spv::Id ray_object_id = 0;
	if (!build_ray_query_object(impl, instruction->getOperand(1), ray_object_id))
		return false;

	auto *op = impl.allocate(spv::OpRayQueryGetIntersectionCandidateAABBOpaqueKHR, builder.makeBoolType());
	op->add_id(ray_object_id);
	impl.add(op);

	auto *not_op = impl.allocate(spv::OpLogicalNot, instruction);
	not_op->add_id(op->id);
	impl.add(not_op);
	return true;
}

static bool is_hit_object_type(const llvm::Type *type)
{
	auto *s = llvm::dyn_cast<llvm::StructType>(type);
	return s && s->hasName() && s->getName() == "dx.types.HitObject";
}

bool type_contains_hitobject(const llvm::Type *type)
{
	if (is_hit_object_type(type))
		return true;
	if (auto *array = llvm::dyn_cast<llvm::ArrayType>(type))
		return type_contains_hitobject(array->getArrayElementType());
	if (auto *s = llvm::dyn_cast<llvm::StructType>(type))
		for (unsigned i = 0; i < s->getStructNumElements(); ++i)
			if (type_contains_hitobject(s->getStructElementType(i)))
				return true;
	return false;
}

static void collect_hit_object_paths(const llvm::Type *type, Vector<uint32_t> &path,
                                     Vector<Vector<uint32_t>> &paths)
{
	if (is_hit_object_type(type))
	{
		path.push_back(0); // Slot field of the lowered logical value.
		paths.push_back(path);
		path.pop_back();
	}
	else if (auto *array = llvm::dyn_cast<llvm::ArrayType>(type))
	{
		if (!type_contains_hitobject(array->getArrayElementType()))
			return;
		for (uint32_t i = 0; i < array->getArrayNumElements(); ++i)
		{
			path.push_back(i);
			collect_hit_object_paths(array->getArrayElementType(), path, paths);
			path.pop_back();
		}
	}
	else if (auto *s = llvm::dyn_cast<llvm::StructType>(type))
		for (uint32_t i = 0; i < s->getStructNumElements(); ++i)
		{
			path.push_back(i);
			collect_hit_object_paths(s->getStructElementType(i), path, paths);
			path.pop_back();
		}
}

static void initialize_hit_object_pool(Converter::Impl &impl, const llvm::Instruction *inst)
{
	auto &pool = impl.hit_object.pool;
	if (pool.objects)
		return;
	auto &builder = impl.builder();
	for (auto *bb : impl.hit_object.blocks)
		for (auto &value : *bb)
		{
			Vector<uint32_t> path;
			Vector<Vector<uint32_t>> paths;
			collect_hit_object_paths(value.getType(), path, paths);
			for (auto &p : paths)
				pool.references.push_back({ &value, impl.create_variable_with_initializer(
				    spv::StorageClassPrivate, builder.makeUintType(32), builder.makeUintConstant(~0u)), p });
			if (auto *alloca = llvm::dyn_cast<llvm::AllocaInst>(&value))
			{
				auto *type = alloca->getType()->getPointerElementType();
				if (!type_contains_hitobject(type))
					continue;
				auto type_id = impl.get_type_id(type);
				auto var = impl.create_variable_with_initializer(
				    spv::StorageClassPrivate, type_id, builder.makeNullConstant(type_id));
				impl.rewrite_value(alloca, var);
				paths.clear();
				collect_hit_object_paths(type, path, paths);
				for (auto &p : paths)
					pool.memory_references.push_back({ var, p });
			}
		}
	// Each SSA value and local-memory cell retains at most one slot. One extra
	// constructor destination guarantees progress, including loop-carried values.
	// A final slot is reserved for unbound no-op invocation.
	auto type = builder.makeArrayType(builder.makeHitObjectType(),
	    builder.makeUintConstant(uint32_t(pool.references.size() + pool.memory_references.size() + 2)), 0);
	pool.objects = impl.create_variable(spv::StorageClassPrivate, type);
}

void emit_hitobject_alloca(Converter::Impl &impl, const llvm::AllocaInst *inst)
{
	// Private per-invocation storage keeps local copies visible to the allocator
	// across the nonrecursive call graph. The normal GEP/load/store lowering applies.
	initialize_hit_object_pool(impl, inst);
}

static spv::Id hit_object_component(Converter::Impl &impl, spv::Id value, uint32_t component)
{
	auto *op = impl.allocate(spv::OpCompositeExtract, impl.builder().makeUintType(32));
	op->add_id(value);
	op->add_literal(component);
	impl.add(op);
	return op->id;
}

static spv::Id hit_object_pointer(Converter::Impl &impl, const llvm::Instruction *inst, spv::Id slot)
{
	initialize_hit_object_pool(impl, inst);
	auto &builder = impl.builder();
	auto *op = impl.allocate(spv::OpAccessChain,
	    builder.makePointer(spv::StorageClassPrivate, builder.makeHitObjectType()));
	op->add_id(impl.hit_object.pool.objects);
	op->add_id(slot);
	impl.add(op);
	return op->id;
}

void emit_hitobject_reference(Converter::Impl &impl, const llvm::Instruction *inst)
{
	if (!type_contains_hitobject(inst->getType()))
		return;
	initialize_hit_object_pool(impl, inst);
	for (auto &reference : impl.hit_object.pool.references)
	{
		if (reference.value != inst)
			continue;
		auto *slot = impl.allocate(spv::OpCompositeExtract, impl.builder().makeUintType(32));
		slot->add_id(impl.get_id_for_value(inst));
		for (auto index : reference.path)
			slot->add_literal(index);
		impl.add(slot);
		auto *op = impl.allocate(spv::OpStore);
		op->add_ids({ reference.variable, slot->id });
		impl.add(op);
	}
}

static spv::Id build_hit_object(Converter::Impl &impl, const llvm::CallInst *inst, spv::Id &slot)
{
	initialize_hit_object_pool(impl, inst);
	auto &builder = impl.builder();
	auto &pool = impl.hit_object.pool;
	Vector<spv::Id> retained;
	for (auto &reference : pool.references)
	{
		auto *op = impl.allocate(spv::OpLoad, builder.makeUintType(32));
		op->add_id(reference.variable);
		impl.add(op);
		retained.push_back(op->id);
	}
	for (auto &reference : pool.memory_references)
	{
		auto *ptr = impl.allocate(spv::OpAccessChain,
		    builder.makePointer(spv::StorageClassPrivate, builder.makeUintType(32)));
		ptr->add_id(reference.first);
		for (auto index : reference.second)
			ptr->add_id(builder.makeUintConstant(index));
		impl.add(ptr);
		auto *op = impl.allocate(spv::OpLoad, builder.makeUintType(32));
		op->add_id(ptr->id);
		impl.add(op);
		retained.push_back(op->id);
	}
	slot = builder.makeUintConstant(uint32_t(retained.size()));
	for (uint32_t candidate = uint32_t(retained.size()); candidate;)
	{
		--candidate;
		auto candidate_id = builder.makeUintConstant(candidate);
		auto free = builder.makeBoolConstant(true);
		for (auto reference : retained)
		{
			auto *unequal = impl.allocate(spv::OpINotEqual, builder.makeBoolType());
			unequal->add_ids({ candidate_id, reference });
			impl.add(unequal);
			auto *both = impl.allocate(spv::OpLogicalAnd, builder.makeBoolType());
			both->add_ids({ free, unequal->id });
			impl.add(both);
			free = both->id;
		}
		auto *select = impl.allocate(spv::OpSelect, builder.makeUintType(32));
		select->add_ids({ free, candidate_id, slot });
		impl.add(select);
		slot = select->id;
	}
	return hit_object_pointer(impl, inst, slot);
}

static void publish_hit_object(Converter::Impl &impl, const llvm::CallInst *inst,
                               spv::Id slot, spv::Id sbt, bool bound)
{
	spv::Id components[] = { slot, sbt, impl.builder().makeUintConstant(bound ? 1 : 0) };
	impl.rewrite_value(inst, impl.build_vector(impl.builder().makeUintType(32), components, 3));

}

static spv::Id consume_hit_object(Converter::Impl &impl, const llvm::CallInst *inst,
                                  bool apply_binding = false, bool suppress_unbound = false)
{
	auto &builder = impl.builder();
	auto value = impl.get_id_for_value(inst->getOperand(1));
	auto slot = hit_object_component(impl, value, 0);
	if (suppress_unbound)
	{
		// A reserved empty slot implements unbound invocation without executing
		// hit record zero. Select indices rather than opaque pointers.
		auto &pool = impl.hit_object.pool;
		auto empty_slot = builder.makeUintConstant(uint32_t(pool.references.size() + pool.memory_references.size() + 1));
		auto empty = hit_object_pointer(impl, inst, empty_slot);
		auto *record = impl.allocate(spv::OpHitObjectRecordEmptyEXT);
		record->add_id(empty);
		impl.add(record);
		auto bound = hit_object_component(impl, value, 2);
		auto *test = impl.allocate(spv::OpINotEqual, builder.makeBoolType());
		test->add_ids({ bound, builder.makeUintConstant(0) });
		impl.add(test);
		auto *select = impl.allocate(spv::OpSelect, builder.makeUintType(32));
		select->add_ids({ test->id, slot, empty_slot });
		impl.add(select);
		slot = select->id;
	}
	auto ptr = hit_object_pointer(impl, inst, slot);
	if (apply_binding)
	{
		auto sbt = hit_object_component(impl, value, 1);
		auto *op = impl.allocate(spv::OpHitObjectSetShaderBindingTableRecordIndexEXT);
		op->add_ids({ ptr, sbt });
		impl.add(op);
	}
	return ptr;
}

bool emit_hit_object_trace_ray_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id acceleration_structure = impl.get_id_for_value(inst->getOperand(1));
	spv::Id ray_flags = impl.build_ray_flags_without_unsupported_omm(inst->getOperand(2), impl.options.opacity_micromap_enabled);
	spv::Id instance_inclusion_mask = impl.get_id_for_value(inst->getOperand(3));
	spv::Id ray_contribution_to_hit_group = impl.get_id_for_value(inst->getOperand(4));
	spv::Id multiplier_for_geometry = impl.get_id_for_value(inst->getOperand(5));
	spv::Id miss_shader_index = impl.get_id_for_value(inst->getOperand(6));

	spv::Id ray_origin[3];
	spv::Id ray_dir[3];

	for (unsigned i = 0; i < 3; i++)
	{
		ray_origin[i] = impl.get_id_for_value(inst->getOperand(7 + i));
		ray_dir[i] = impl.get_id_for_value(inst->getOperand(11 + i));
	}

	spv::Id tmin = impl.get_id_for_value(inst->getOperand(10));
	spv::Id tmax = impl.get_id_for_value(inst->getOperand(14));

	spv::Id ray_origin_vec = impl.build_vector(builder.makeFloatType(32), ray_origin, 3);
	spv::Id ray_dir_vec = impl.build_vector(builder.makeFloatType(32), ray_dir, 3);

	auto *ray_payload = inst->getOperand(15);

	bool needs_temp_copy = impl.get_needs_temp_storage_copy(ray_payload);
	spv::Id ray_payload_var_id = needs_temp_copy
		? emit_temp_storage_copy(impl, ray_payload, spv::StorageClassRayPayloadKHR)
		: impl.get_id_for_value(ray_payload);

	spv::Id slot;
	spv::Id hit_object = build_hit_object(impl, inst, slot);

	auto *op = impl.allocate(spv::OpHitObjectTraceRayEXT);
	op->add_ids({
	    hit_object,
	    acceleration_structure,
	    ray_flags,
	    instance_inclusion_mask,
	    ray_contribution_to_hit_group,
	    multiplier_for_geometry,
	    miss_shader_index,
	    ray_origin_vec,
	    tmin,
	    ray_dir_vec,
	    tmax,
	    ray_payload_var_id
	});
	impl.add(op);

	// In this instance, the ray_payload_var_id is our temp.
	if (needs_temp_copy)
		emit_temp_storage_resolve(impl, ray_payload, ray_payload_var_id);

	auto *sbt = impl.allocate(spv::OpHitObjectGetShaderBindingTableRecordIndexEXT, builder.makeUintType(32));
	sbt->add_id(hit_object);
	impl.add(sbt);
	auto *empty = impl.allocate(spv::OpHitObjectIsEmptyEXT, builder.makeBoolType());
	empty->add_id(hit_object);
	impl.add(empty);
	auto *index = impl.allocate(spv::OpSelect, builder.makeUintType(32));
	index->add_ids({ empty->id, builder.makeUintConstant(0), sbt->id });
	impl.add(index);
	publish_hit_object(impl, inst, slot, index->id, true);

	return true;
}

bool emit_hit_object_from_ray_query_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id ray_query = impl.get_id_for_value(inst->getOperand(1));

	spv::Id slot;
	spv::Id hit_object = build_hit_object(impl, inst, slot);

	spv::Id sbt_record_index = builder.makeUintConstant(0);
    spv::Id empty_struct = builder.makeStructType({}, "EmptyStruct");
	spv::Id empty_attributes = impl.create_variable(spv::StorageClassHitObjectAttributeEXT, empty_struct);

	auto *op = impl.allocate(spv::OpHitObjectRecordFromQueryEXT);
	op->add_ids({
	    hit_object,
		ray_query,
		sbt_record_index,
		empty_attributes
	});
	impl.add(op);

	publish_hit_object(impl, inst, slot, sbt_record_index, false);

	return true;
}

bool emit_hit_object_from_ray_query_with_attrs_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id ray_query = impl.get_id_for_value(inst->getOperand(1));
	spv::Id hit_kind = impl.get_id_for_value(inst->getOperand(2));
	spv::Id attributes = impl.get_id_for_value(inst->getOperand(3));

	spv::Id slot;
	spv::Id hit_object = build_hit_object(impl, inst, slot);

	// This is an incompatibility with HLSL. FromRayQuery should start off with a pseudo-nop state
	// until an SBT is assigned.
	spv::Id sbt_record_index = builder.makeUintConstant(0);

	auto *op = impl.allocate(spv::OpHitObjectRecordFromQueryEXT);
	op->add_ids({
	    hit_object,
		ray_query,
		sbt_record_index,
		attributes,
		hit_kind
	});
	impl.add(op);

	publish_hit_object(impl, inst, slot, sbt_record_index, false);

	return true;
}

bool emit_hit_object_make_miss_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id slot;
	spv::Id hit_object = build_hit_object(impl, inst, slot);

	spv::Id ray_flags = impl.get_id_for_value(inst->getOperand(1));
	spv::Id miss_shader_index = impl.get_id_for_value(inst->getOperand(2));

	spv::Id ray_origin[3];
	spv::Id ray_dir[3];

	for (unsigned i = 0; i < 3; i++)
	{
		ray_origin[i] = impl.get_id_for_value(inst->getOperand(3 + i));
		ray_dir[i] = impl.get_id_for_value(inst->getOperand(7 + i));
	}

	spv::Id tmin = impl.get_id_for_value(inst->getOperand(6));
	spv::Id tmax = impl.get_id_for_value(inst->getOperand(10));

	spv::Id ray_origin_vec = impl.build_vector(builder.makeFloatType(32), ray_origin, 3);
	spv::Id ray_dir_vec = impl.build_vector(builder.makeFloatType(32), ray_dir, 3);

	auto *op = impl.allocate(spv::OpHitObjectRecordMissEXT);
	op->add_ids({
	    hit_object,
	    ray_flags,
	    miss_shader_index,
	    ray_origin_vec,
	    tmin,
	    ray_dir_vec,
	    tmax,
	});
	impl.add(op);

	auto *index = impl.allocate(spv::OpBitwiseAnd, builder.makeUintType(32));
	index->add_ids({ miss_shader_index, builder.makeUintConstant(0xffff) });
	impl.add(index);
	publish_hit_object(impl, inst, slot, index->id, true);

	return true;
}

bool emit_hit_object_make_nop_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id slot;
	spv::Id hit_object = build_hit_object(impl, inst, slot);

	auto *op = impl.allocate(spv::OpHitObjectRecordEmptyEXT);
	op->add_id(hit_object);
	impl.add(op);

	publish_hit_object(impl, inst, slot, builder.makeUintConstant(0), false);

	return true;
}

bool emit_hit_object_invoke_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id hit_object = consume_hit_object(impl, inst, true, true);
	auto *ray_payload = inst->getOperand(2);

	bool needs_temp_copy = impl.get_needs_temp_storage_copy(ray_payload);
	spv::Id ray_payload_var_id = needs_temp_copy
		? emit_temp_storage_copy(impl, ray_payload, spv::StorageClassRayPayloadKHR)
		: impl.get_id_for_value(ray_payload);

	auto *op = impl.allocate(spv::OpHitObjectExecuteShaderEXT);
	op->add_ids({
	    hit_object,
	    ray_payload_var_id
	});
	impl.add(op);

	if (needs_temp_copy)
		emit_temp_storage_resolve(impl, ray_payload, ray_payload_var_id);

	return true;
}

bool emit_maybe_reoder_thread_instruction(Converter::Impl &impl, const llvm::CallInst *inst)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id hint = impl.get_id_for_value(inst->getOperand(2));
	spv::Id bits = impl.get_id_for_value(inst->getOperand(3));
	spv::Id hit_object = consume_hit_object(impl, inst, true, true);

	auto *op = impl.allocate(spv::OpReorderThreadWithHitObjectEXT);
	op->add_ids({
		hit_object,
		hint,
		bits
	});
	impl.add(op);

	return true;
}

bool emit_hit_object_get_value_instruction(Converter::Impl &impl, const llvm::CallInst *instruction,
                                           spv::Op opcode, uint32_t vecsize)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	if (opcode == spv::OpHitObjectGetShaderBindingTableRecordIndexEXT)
	{
		impl.rewrite_value(instruction, hit_object_component(impl,
		    impl.get_id_for_value(instruction->getOperand(1)), 1));
		return true;
	}

	spv::Id hit_object = consume_hit_object(impl, instruction);

	if (vecsize == 1)
	{
		auto *op = impl.allocate(opcode, instruction);
		op->add_id(hit_object);
		impl.add(op);
	}
	else
	{
		auto *op = impl.allocate(opcode, builder.makeVectorType(impl.get_type_id(instruction->getType()), vecsize));
		op->add_id(hit_object);
		impl.add(op);
		auto *extract_op = impl.allocate(spv::OpCompositeExtract, instruction);
		extract_op->add_id(op->id);

		uint32_t index = 0;
		if (!get_constant_operand(instruction, 2, &index))
			return false;
		extract_op->add_literal(index);
		impl.add(extract_op);
	}
	return true;
}

bool emit_hit_object_get_matrix_value_instruction(Converter::Impl &impl, const llvm::CallInst *instruction,
                                                  spv::Op opcode)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id hit_object = consume_hit_object(impl, instruction);

	auto *op = impl.allocate(opcode, builder.makeMatrixType(impl.get_type_id(instruction->getType()), 4, 3));
	op->add_id(hit_object);
	impl.add(op);

	auto *extract_op = impl.allocate(spv::OpCompositeExtract, instruction);
	uint32_t row = 0, col = 0;
	if (!get_constant_operand(instruction, 2, &row))
		return false;
	if (!get_constant_operand(instruction, 3, &col))
		return false;
	extract_op->add_id(op->id);
	extract_op->add_literal(col);
	extract_op->add_literal(row);
	impl.add(extract_op);
	return true;
}

bool emit_hit_object_set_shader_table_index_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id hit_object = consume_hit_object(impl, instruction);
	spv::Id shader_table_index = impl.get_id_for_value(instruction->getOperand(2));

	auto *is_hit = impl.allocate(spv::OpHitObjectIsHitEXT, builder.makeBoolType());
	is_hit->add_id(hit_object);
	impl.add(is_hit);

	// DXR version of this explicitly asks for masking based on the type of object.
	// 28 bits are used for hit, 16 bit for miss and empty object is ignored anyway, so whatever.
	auto *mask = impl.allocate(spv::OpSelect, builder.makeUintType(32));
	mask->add_id(is_hit->id);
	mask->add_id(builder.makeUintConstant(0x0fffffff));
	mask->add_id(builder.makeUintConstant(0x0000ffff));
	impl.add(mask);

	auto *masked = impl.allocate(spv::OpBitwiseAnd, builder.makeUintType(32));
	masked->add_id(shader_table_index);
	masked->add_id(mask->id);
	impl.add(masked);

	auto value = impl.get_id_for_value(instruction->getOperand(1));
	auto slot = hit_object_component(impl, value, 0);
	auto *empty = impl.allocate(spv::OpHitObjectIsEmptyEXT, builder.makeBoolType());
	empty->add_id(hit_object);
	impl.add(empty);
	auto *index = impl.allocate(spv::OpSelect, builder.makeUintType(32));
	index->add_ids({ empty->id, builder.makeUintConstant(0), masked->id });
	impl.add(index);
	publish_hit_object(impl, instruction, slot, index->id, true);
	return true;
}

bool emit_hit_object_load_local_root_table_constant_instruction(Converter::Impl &impl,
                                                                const llvm::CallInst *instruction)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id hit_object = consume_hit_object(impl, instruction, true, true);
	spv::Id offset = impl.get_id_for_value(instruction->getOperand(2));

	spv::Id uint32 = builder.makeUintType(32);

	if (!impl.hit_object.shader_record_buffer_ptr)
	{
		spv::Id srb_array = builder.makeRuntimeArray(uint32);
		builder.addDecoration(srb_array, spv::DecorationArrayStride, sizeof(uint32_t));

		spv::Id srb_struct = builder.makeStructType({ srb_array }, "HitObjectSRB");

		builder.addDecoration(srb_struct, spv::DecorationBlock);
		builder.addDecoration(srb_struct, spv::DecorationHitObjectShaderRecordBufferEXT);

		builder.addMemberDecoration(srb_struct, 0, spv::DecorationOffset, 0);
		builder.addMemberDecoration(srb_struct, 0, spv::DecorationNonWritable);

		impl.hit_object.shader_record_buffer_ptr = builder.makePointer(spv::StorageClassPhysicalStorageBuffer, srb_struct);
		impl.hit_object.shader_record_buffer_member_ptr = builder.makePointer(spv::StorageClassPhysicalStorageBuffer, uint32);
	}

	auto *op = impl.allocate(spv::OpHitObjectGetShaderRecordBufferHandleEXT, builder.makeVectorType(uint32, 2));
	op->add_id(hit_object);
	impl.add(op);

	auto *is_empty = impl.allocate(spv::OpHitObjectIsEmptyEXT, builder.makeBoolType());
	is_empty->add_id(hit_object);
	impl.add(is_empty);

	auto *not_empty = impl.allocate(spv::OpLogicalNot, builder.makeBoolType());
	not_empty->add_id(is_empty->id);
	impl.add(not_empty);

	auto *cast_op = impl.allocate(spv::OpBitcast, impl.hit_object.shader_record_buffer_ptr);
	cast_op->add_id(op->id);
	impl.add(cast_op);

	auto *index_op = impl.allocate(spv::OpShiftRightLogical, uint32);
	index_op->add_id(offset);
	index_op->add_id(builder.makeUintConstant(2));
	impl.add(index_op);

	auto *chain_op = impl.allocate(spv::OpInBoundsAccessChain, impl.hit_object.shader_record_buffer_member_ptr);
	chain_op->add_id(cast_op->id);
	chain_op->add_id(builder.makeUintConstant(0));
	chain_op->add_id(index_op->id);
	impl.add(chain_op);

	// Need robustness here since an empty hit object should always return 0, but if we just get a random pointer
	// it's not going to work.
	auto *load_op = impl.allocate(spv::PseudoOpMaskedLoad, uint32);
	load_op->add_id(chain_op->id);
	load_op->add_literal(spv::MemoryAccessAlignedMask);
	load_op->add_literal(sizeof(uint32_t));
	load_op->add_id(not_empty->id);
	impl.add(load_op);

	impl.rewrite_value(instruction, load_op->id);
	return true;
}

bool emit_hit_object_attributes_instruction(Converter::Impl &impl, const llvm::CallInst *instruction)
{
	auto &builder = impl.builder();

	builder.addExtension("SPV_EXT_shader_invocation_reorder");
	builder.addCapability(spv::CapabilityShaderInvocationReorderEXT);

	spv::Id hit_object = consume_hit_object(impl, instruction);
	spv::Id attributes = impl.get_id_for_value(instruction->getOperand(2));

	auto *op = impl.allocate(spv::OpHitObjectGetAttributesEXT);
	op->add_ids({
	    hit_object,
	    attributes
	});
	impl.add(op);

    auto *is_hit = impl.allocate(spv::OpHitObjectIsHitEXT, builder.makeBoolType());
    is_hit->add_id(hit_object);
    impl.add(is_hit);

    auto *not_hit = impl.allocate(spv::OpLogicalNot, builder.makeBoolType());
    not_hit->add_id(is_hit->id);
    impl.add(not_hit);

    // NVIDIA driver doesn't seem to clear out miss/nop to null properly.
    // It's unclear from SPIR-V spec what should happen.
    auto *store = impl.allocate(spv::PseudoOpMaskedStore);
    store->add_id(attributes);
    store->add_id(builder.makeNullConstant(impl.get_type_id(instruction->getOperand(2)->getType()->getPointerElementType())));
    store->add_id(not_hit->id);
    impl.add(store);

	return true;
}

}
