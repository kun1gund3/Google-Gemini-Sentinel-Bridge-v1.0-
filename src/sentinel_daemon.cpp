#include <iostream>
#include <fstream>
#include <thread>
#include <chrono>
#include <nlohmann/json.hpp>
#include <filesystem>

namespace fs = std::filesystem;
using json = nlohmann::json;

void update_hw_state() {
    std::string home = getenv("HOME");
    std::string state_path = home + "/.gemini/hw_state.json";
    std::string history_path = home + "/.gemini/hw_history.jsonl";

    while (true) {
        std::ifstream cap_file("/sys/class/power_supply/battery/capacity");
        std::ifstream temp_file("/sys/class/power_supply/battery/temp");
        
        int capacity = 0;
        int temp_raw = 0;
        cap_file >> capacity;
        temp_file >> temp_raw;
        float temp_c = temp_raw / 10.0f;

        json hw_state;
        hw_state["capacity"] = capacity;
        hw_state["temperature_c"] = temp_c;
        // Stabiler Unix-Timestamp
        hw_state["timestamp"] = std::chrono::duration_cast<std::chrono::seconds>(
            std::chrono::system_clock::now().time_since_epoch()
        ).count();

        // Aktuellen Status schreiben (atomar via rename)
        std::ofstream out(state_path + ".tmp");
        out << hw_state.dump();
        out.close();
        fs::rename(state_path + ".tmp", state_path);

        // Historie für v1.5 Training
        std::ofstream history_out(history_path, std::ios_base::app);
        history_out << hw_state.dump() << std::endl;
        history_out.close();

        std::this_thread::sleep_for(std::chrono::seconds(10));
    }
}

int main() {
    std::cout << "\033[1;32m[Sentinel-Daemon]\033[0m v1.5 Logging-Mode aktiv." << std::endl;
    update_hw_state();
    return 0;
}
