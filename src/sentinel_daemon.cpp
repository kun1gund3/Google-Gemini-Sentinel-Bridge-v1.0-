#include <iostream>
#include <fstream>
#include <thread>
#include <chrono>
#include <nlohmann/json.hpp>
#include <filesystem>

namespace fs = std::filesystem;
using json = nlohmann::json;

void update_hw_state() {
    std::string state_path = std::string(getenv("HOME")) + "/.gemini/hw_state.json";
    while (true) {
        std::ifstream cap_file("/sys/class/power_supply/battery/capacity");
        int capacity = 0;
        if (cap_file.is_open()) {
            cap_file >> capacity;
        }

        json hw_state;
        hw_state["capacity"] = capacity;
        hw_state["timestamp"] = std::chrono::system_clock::now().time_since_epoch().count();

        std::ofstream out(state_path + ".tmp");
        out << hw_state.dump();
        out.close();
        fs::rename(state_path + ".tmp", state_path);

        std::this_thread::sleep_for(std::chrono::seconds(5));
    }
}

int main() {
    std::cout << "Sentinel-Daemon started..." << std::endl;
    update_hw_state();
    return 0;
}
