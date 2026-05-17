#include <iostream>
#include <dlfcn.h>

int main() {
    std::cout << "\033[1;32m[Sentinel-Probe]\033[0m Teste GPU-Gateway (OpenCL)..." << std::endl;
    
    // Standard-Pfad für OpenCL auf Samsung Geräten
    const char* cl_lib = "/system/vendor/lib64/libOpenCL.so";
    
    void* handle = dlopen(cl_lib, RTLD_NOW);
    if (handle) {
        std::cout << "✅ GPU-Beschleunigung möglich: libOpenCL.so erreichbar." << std::endl;
        dlclose(handle);
    } else {
        std::cout << "❌ OpenCL nicht direkt erreichbar. (Error: " << dlerror() << ")" << std::endl;
        std::cout << "Tipp: Wir werden 'libopencl-stub' nutzen müssen." << std::endl;
    }
    return 0;
}
