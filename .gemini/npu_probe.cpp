#include <iostream>
#include <dlfcn.h>

int main() {
    std::cout << "\033[1;34m[Sentinel-Probe]\033[0m Teste NPU-Gateways..." << std::endl;

    const char* libs[] = {
        "/vendor/lib64/libadsprpc.so",
        "/vendor/lib64/libTfliteNpuDelegate.so"
    };

    for (const char* lib_path : libs) {
        void* handle = dlopen(lib_path, RTLD_NOW);
        if (handle) {
            std::cout << "✅ Erreichbar: " << lib_path << std::endl;
            dlclose(handle);
        } else {
            std::cout << "❌ Fehlgeschlagen: " << lib_path << " (Error: " << dlerror() << ")" << std::endl;
        }
    }
    return 0;
}
