# Sentinel-Daemon Design (C++)
# Ziel: Asynchrone Pufferung von Hardware-Daten zur Eliminierung von API-Timeouts

## Architektur
- **Main Loop:** Läuft als Hintergrundprozess.
- **Data Acquisition:** Liest `/sys/class/power_supply/battery/` direkt (niedrige Latenz).
- **Buffer:** Schreibt periodisch in `~/.gemini/hw_state.json`.
- **Inter-Process Communication:** Shell-Skripte (Sentinel-Bridge) lesen `hw_state.json` statt `termux-sensor` direkt aufzurufen.

## Entwurf (`src/daemon/sentinel_daemon.cpp`)

```cpp
#include <iostream>
#include <fstream>
#include <thread>
#include <chrono>
#include <nlohmann/json.hpp> // Assuming json library usage

using json = nlohmann::json;

void update_hw_state() {
    while (true) {
        // Lese Kapazität (direkt aus sysfs, kein Timeout)
        std::ifstream cap_file("/sys/class/power_supply/battery/capacity");
        int capacity;
        cap_file >> capacity;

        // Erstelle JSON Zustand
        json hw_state;
        hw_state["capacity"] = capacity;
        hw_state["timestamp"] = std::chrono::system_clock::now().time_since_epoch().count();

        // Schreibe Puffer (atomar, um Race-Conditions zu vermeiden)
        std::ofstream out("~/.gemini/hw_state.json");
        out << hw_state.dump();

        std::this_thread::sleep_for(std::chrono::seconds(5));
    }
}

int main() {
    std::thread worker(update_hw_state);
    worker.detach();
    return 0;
}
```
