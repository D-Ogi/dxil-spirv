#include <windows.h>
#include <dxcapi.h>
#include <cstdio>
#include <fstream>
#include <iterator>
#include <string>
int main(int argc, char **argv)
{
    if (argc != 4) return 2;
    SetDllDirectoryA(argv[1]);
    auto mod = LoadLibraryA("dxcompiler.dll");
    if (!mod) return 3;
    auto create = reinterpret_cast<DxcCreateInstanceProc>(GetProcAddress(mod, "DxcCreateInstance"));
    IDxcLibrary *lib = nullptr;
    IDxcAssembler *assembler = nullptr;
    if (FAILED(create(CLSID_DxcLibrary, IID_PPV_ARGS(&lib))) ||
        FAILED(create(CLSID_DxcAssembler, IID_PPV_ARGS(&assembler)))) return 4;
    std::ifstream file(argv[2], std::ios::binary);
    std::string text((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    IDxcBlobEncoding *input = nullptr;
    lib->CreateBlobWithEncodingFromPinned(text.data(), unsigned(text.size()), CP_UTF8, &input);
    IDxcOperationResult *result = nullptr;
    auto hr = assembler->AssembleToContainer(input, &result);
    if (FAILED(hr) || !result) return 5;
    IDxcBlobEncoding *errors = nullptr;
    result->GetErrorBuffer(&errors);
    if (errors && errors->GetBufferSize()) fwrite(errors->GetBufferPointer(), 1, errors->GetBufferSize(), stderr);
    result->GetStatus(&hr);
    if (FAILED(hr)) return 6;
    IDxcBlob *output = nullptr;
    result->GetResult(&output);
    std::ofstream out(argv[3], std::ios::binary);
    out.write(static_cast<char *>(output->GetBufferPointer()), output->GetBufferSize());
    return out ? 0 : 7;
}
