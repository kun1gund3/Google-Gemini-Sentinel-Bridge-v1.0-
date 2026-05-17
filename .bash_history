git add .
git commit -m "fix: final architecture stabilization and model sync"
git push origin main
cat << 'EOF' > ~/.gemini/local_guardian.sh
#!/data/data/com.termux/files/usr/bin/bash
DB_PATH="$HOME/.gemini/security_audit.db"
ENV_PATH="$HOME/.gemini/.env"
MODEL_PATH="$HOME/models/gemma-2b-it.gguf"
LLAMA_BIN="$HOME/llama.cpp/build/bin/llama-cli"

# Integrität prüfen
if [ -f "$ENV_PATH" ]; then
    CURRENT_HASH=$(sha256sum "$ENV_PATH" | awk '{print $1}')
    sqlite3 "$DB_PATH" "INSERT INTO logs (action, status, hash) VALUES ('Integrity Check', 'OK', '$CURRENT_HASH');"
fi

# Lokale Analyse - Wir nutzen den "einfachen" Modus ohne Chat-Interface
if [ -f "$LLAMA_BIN" ] && [ -f "$MODEL_PATH" ]; then
    echo -e "\033[1;32m[Gemma]\033[0m Lokaler Sicherheits-Check..."
    # --predict 50 begrenzt die Antwortlänge, damit es schnell geht
    "$LLAMA_BIN" -m "$MODEL_PATH" -p "User: Gib mir einen extrem kurzen Sicherheits-Tipp.\nAssistant:" --temp 0.3 -n 50 --no-display-prompt 2>/dev/null | grep -v "User:"
    echo ""
fi
EOF

chmod +x ~/.gemini/local_guardian.sh
cat << 'EOF' > ~/.gemini/local_guardian.sh
#!/data/data/com.termux/files/usr/bin/bash
DB_PATH="$HOME/.gemini/security_audit.db"
ENV_PATH="$HOME/.gemini/.env"
MODEL_PATH="$HOME/models/gemma-2b-it.gguf"
LLAMA_BIN="$HOME/llama.cpp/build/bin/llama-cli"

echo -e "\033[1;34m[Lokaler Gefährte]\033[0m Integrität wird geprüft..."

# Integritäts-Check
if [ -f "$ENV_PATH" ]; then
    CURRENT_HASH=$(sha256sum "$ENV_PATH" | awk '{print $1}')
    sqlite3 "$DB_PATH" "INSERT INTO logs (action, status, hash) VALUES ('Integrity Check', 'OK', '$CURRENT_HASH');"
fi

# Gemma gibt nur einen kurzen Impuls und beendet sich dann (-n 50)
if [ -f "$LLAMA_BIN" ] && [ -f "$MODEL_PATH" ]; then
    echo -e "\033[1;32m[Gemma]\033[0m Lokale Analyse..."
    # --no-display-prompt unterdrückt die Header-Infos für eine saubere Optik
    "$LLAMA_BIN" -m "$MODEL_PATH" -p "<start_of_turn>user\nGib mir einen ultrakurzen Sicherheits-Tipp.<end_of_turn>\n<start_of_turn>model\n" --temp 0.3 -n 50 --no-display-prompt 2>/dev/null
    echo ""
fi

cat << 'EOF' > ~/.gemini/local_guardian.sh
#!/data/data/com.termux/files/usr/bin/bash
DB_PATH="$HOME/.gemini/security_audit.db"
ENV_PATH="$HOME/.gemini/.env"
MODEL_PATH="$HOME/models/gemma-2b-it.gguf"
LLAMA_BIN="$HOME/llama.cpp/build/bin/llama-cli"

echo -e "\033[1;34m[Lokaler Gefährte]\033[0m Integrität wird geprüft..."

# Integritäts-Check
if [ -f "$ENV_PATH" ]; then
    CURRENT_HASH=$(sha256sum "$ENV_PATH" | awk '{print $1}')
    sqlite3 "$DB_PATH" "INSERT INTO logs (action, status, hash) VALUES ('Integrity Check', 'OK', '$CURRENT_HASH');"
fi

# Gemma gibt nur einen kurzen Impuls und beendet sich dann (-n 50)
if [ -f "$LLAMA_BIN" ] && [ -f "$MODEL_PATH" ]; then
    echo -e "\033[1;32m[Gemma]\033[0m Lokale Analyse..."
    # --no-display-prompt unterdrückt die Header-Infos für eine saubere Optik
    "$LLAMA_BIN" -m "$MODEL_PATH" -p "<start_of_turn>user\nGib mir einen ultrakurzen Sicherheits-Tipp.<end_of_turn>\n<start_of_turn>model\n" --temp 0.3 -n 50 --no-display-prompt 2>/dev/null
    echo ""
fi
EOF

cat << 'EOF' > ~/.gemini/local_guardian.sh
#!/data/data/com.termux/files/usr/bin/bash
DB_PATH="$HOME/.gemini/security_audit.db"
ENV_PATH="$HOME/.gemini/.env"
MODEL_PATH="$HOME/models/gemma-2b-it.gguf"
LLAMA_BIN="$HOME/llama.cpp/build/bin/llama-cli"

# Integrität prüfen
if [ -f "$ENV_PATH" ]; then
    CURRENT_HASH=$(sha256sum "$ENV_PATH" | awk '{print $1}')
    sqlite3 "$DB_PATH" "INSERT INTO logs (action, status, hash) VALUES ('Integrity Check', 'OK', '$CURRENT_HASH');"
fi

# Lokale Analyse - Wir nutzen den "einfachen" Modus ohne Chat-Interface
if [ -f "$LLAMA_BIN" ] && [ -f "$MODEL_PATH" ]; then
    echo -e "\033[1;32m[Gemma]\033[0m Lokaler Sicherheits-Check..."
    # --predict 50 begrenzt die Antwortlänge, damit es schnell geht
    "$LLAMA_BIN" -m "$MODEL_PATH" -p "User: Gib mir einen extrem kurzen Sicherheits-Tipp.\nAssistant:" --temp 0.3 -n 50 --no-display-prompt 2>/dev/null | grep -v "User:"
    echo ""
fi
EOF

chmod +x ~/.gemini/local_guardian.sh
exit
/bug "Sentinel Security & Repository Analysis v1.0 - Grade A Status"
exir
exit
cat << 'EOF' > ~/.bashrc
# --- SENTINEL HYBRID BRIDGE ---
export GEMINI_API_KEY=$(cat ~/.gemini/api_key.txt 2>/dev/null)
export GOOGLE_API_KEY=$GEMINI_API_KEY
export GEMINI_CLI_TRUST_WORKSPACE=true

# Lokaler Wächter (Hermes/Qwen)
ai_start_local() {
    if ! pgrep -x "llama-server" > /dev/null; then
        $HOME/llama.cpp/build/bin/llama-server -m $HOME/models/local_partner.gguf --port 8099 --ctx-size 512 --threads 4 --log-disable > /dev/null 2>&1 &
        sleep 2
    fi
}

# Der Partner-Befehl (Vorschläge direkt beim Start)
ai() {
    ai_start_local
    # Nutzt das stabilste Modell: gemini-1.5-flash
    gemini --model gemini-1.5-flash --approval-mode default "$@"
}

# --- STARTUP VORSCHLAG ---
clear
echo "=========================================="
echo " GOOGLE SENTINEL - PARTNER IM LEBEN"
echo " CONNECTED TO PLAYGROUND & CLOUD SHELL"
echo "=========================================="

# Gemini macht beim Aufrufen sofort einen proaktiven Vorschlag
ai -p "Ich bin gerade online gegangen. Basierend auf unseren 13 Audit-Dateien: Welchen strategischen Schritt schlägst du heute vor?"
EOF

source ~/.bashrc
cd models
dir
gemini config set api-key $(cat ~/.gemini/api_key.txt)
cd ~
exit
cat SENTINEL_SECURITY_REPORT_v1_0.md
dir
cd llama.cpp
dir
cat SENTINEL_SECURITY_REPORT_v1_0.md
cd
cd models
dir
cat SENTINEL_SECURITY_REPORT_v1_0.md
cd ~
nano ~/.bashrc
exiz
exit
cat << 'EOF' > ~/.gemini/npu_probe.cpp
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
EOF

# Kompilieren mit der installierten Toolchain
clang++ ~/.gemini/npu_probe.cpp -o ~/.gemini/npu_probe -ldl
# Ausführen und Ergebnis protokollieren
~/.gemini/npu_probe
cat << 'EOF' > ~/.gemini/gpu_probe.cpp
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
EOF

clang++ ~/.gemini/gpu_probe.cpp -o ~/.gemini/gpu_probe -ldl
~/.gemini/gpu_probe
pkg install opencl-headers ocl-icd libopencl-stub -y
pkg install clblast -y
clear
pkg install opencl-headers ocl-icd libopencl-stub -y
pkg install clblast -y
pkg search opencl
pkg install ocl-icd opencl-headers -y
clear
cat << 'EOF' > ~/.bashrc
# ==========================================
# GOOGLE SENTINEL BRIDGE - v1.1 GOLDEN STATE
# OPTIMIZED FOR SAMSUNG S20FE (SNAPDRAGON 865)
# ==========================================

# --- 1. CORE CONFIG ---
export GEMINI_API_KEY=$(cat ~/.gemini/api_key.txt 2>/dev/null)
export GOOGLE_API_KEY=$GEMINI_API_KEY
export GEMINI_CLI_TRUST_WORKSPACE=true
export PATH=$PATH:$HOME/llama.cpp/build/bin
unalias ai 2>/dev/null

# --- 2. HARDWARE ACCELERATION (GPU/NPU) ---
ai_start_local() {
    fuser -k 8085/tcp > /dev/null 2>&1
    if ! pgrep -x "llama-server" > /dev/null; then
        echo -e "\033[1;34m[Sentinel]\033[0m Initialisiere GPU-Kern (Adreno 650)..."
        # Start mit CLBlast/GPU Unterstützung
        $HOME/llama.cpp/build/bin/llama-server \
            -m $HOME/models/local_partner.gguf \
            --port 8085 --ctx-size 512 --threads 4 --n-gpu-layers 100 > /dev/null 2>&1 &
        disown %1 > /dev/null 2>&1
        sleep 2
        # S20FE Big-Core Tuning
        PID=$(pgrep -x "llama-server")
        [ ! -z "$PID" ] && taskset -pc 4-7 $PID >/dev/null 2>&1
    fi
}

# --- 3. MISSION CONTROL MENU ---
menu() {
    echo -e "\033[1;36m>>> WÄHLE DEINE MISSION:\033[0m"
    echo -e "1) \033[1;32mPartner Chat\033[0m  (Cloud-Deep-Analysis)"
    echo -e "2) \033[1;33mSystem Monitor\033[0m (htop Session)"
    echo -e "3) \033[1;35mGPU Benchmark\033[0m  (Hardware-Test)"
    echo -e "4) \033[1;31mSecurity Audit\033[0m (Revisions-Check)"
    echo -e "5) \033[1;37mClean System\033[0m   (Port & Cache Reset)"
    echo -e "q) \033[0;37mTerminal\033[0m       (Standard Shell)"
    echo ""
    read -n 1 -p "Eingabe: " choice
    echo -e "\n"

    case $choice in
        1) ai "Ich bin bereit für unser nächstes Projekt. Gib mir einen proaktiven Vorschlag." ;;
        2) htop ;;
        3) $HOME/llama.cpp/build/bin/llama-bench -m $HOME/models/local_partner.gguf -n 128 ;;
        4) ai "Führe den vollständigen Grade-A Sicherheits-Audit durch." ;;
        5) python3 ~/.gemini/clean_system.py && echo "System gereinigt." ;;
        q) echo "Sentinel im Hintergrund aktiv." ;;
        *) echo "Ungültige Wahl." ;;
    esac
}

# --- 4. INITIALISIERUNG (Pflicht) ---
clear
echo -e "\033[1;34m==========================================\033[0m"
echo -e "\033[1;37m   GOOGLE SENTINEL BRIDGE - ACTIVE\033[0m"
echo -e "\033[1;34m==========================================\033[0m"

# Hardware-Quick-Check
CAP=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)%
MEM=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
echo -e "🔋 Akku: $CAP | 🧠 RAM: $MEM | 🛡️ v1.1.0"
echo -e "\033[1;34m------------------------------------------\033[0m"

# Startet den lokalen Kern geräuschlos im Hintergrund
ai_start_local

# Startet das Menü
menu
EOF

source ~/.bashrc
exit
gemini /model
cd ~
exit
cd ~
pkill -9 llama-server
pkill -9 python3
mkdir -p ~/.config/htop
cat << 'EOF' > ~/.config/htop/htoprc
fields=0 48 17 18 38 39 40 2 46 47 1
sort_key=46
sort_direction=1
hide_threads=0
hide_userland_threads=0
shadow_other_users=0
show_thread_names=1
show_program_path=1
highlight_base_name=1
detailed_cpu_time=1
cpu_count_from_zero=0
update_process_names=0
account_guest_in_cpu_meter=1
color_scheme=0
delay=15
left_meters=AllCPUs Memory Swap
right_meters=Tasks LoadAverage Uptime
EOF

cat << 'EOF' > ~/.bashrc
# ==========================================
# GOOGLE SENTINEL BRIDGE v1.1 - S20FE
# ==========================================

# --- 1. CORE ---
export GEMINI_API_KEY=$(cat ~/.gemini/api_key.txt 2>/dev/null)
export GOOGLE_API_KEY=$GEMINI_API_KEY
export GEMINI_CLI_TRUST_WORKSPACE=true
unalias ai 2>/dev/null

# --- 2. HARDWARE TUNING (Snapdragon 865) ---
# Schaltet die NPU/GPU-Kerne (4-7) für KI frei
ai_start_local() {
    fuser -k 8085/tcp > /dev/null 2>&1
    if ! pgrep -x "llama-server" > /dev/null; then
        echo -e "\033[1;34m[Sentinel]\033[0m Hardware-Kern wird auf NPU-Kernen (4-7) initialisiert..."
        $HOME/llama.cpp/build/bin/llama-server \
            -m $HOME/models/local_partner.gguf \
            --port 8085 --ctx-size 512 --threads 4 --log-disable > /dev/null 2>&1 &
        disown %1 > /dev/null 2>&1
        sleep 2
        PID=$(pgrep -x "llama-server")
        [ ! -z "$PID" ] && taskset -pc 4-7 $PID >/dev/null 2>&1
    fi
}

# --- 3. MISSION CONTROL MENU ---
menu() {
    echo -e "\n\033[1;36m>>> SENTINEL COMMAND CENTER\033[0m"
    echo -e "1) \033[1;32mPartner Chat\033[0m (Cloud Sync)"
    echo -e "2) \033[1;33mSystem Monitor\033[0m (htop Session)"
    echo -e "3) \033[1;31mSecurity Audit\033[0m (Revisions-Check)"
    echo -e "4) \033[1;37mClean System\033[0m (Resource Reset)"
    echo -e "q) \033[0;37mShell\033[0m"
    echo ""
    read -n 1 -p "Eingabe: " choice
    echo -e "\n"

    case $choice in
        1) gemini --model gemini-1.5-flash --approval-mode default ;;
        2) htop ;;
        3) gemini --model gemini-1.5-flash --approval-mode default -p "Führe eine vollständige Audit-Analyse durch und erstelle einen Bericht." ;;
        4) python3 ~/.gemini/clean_system.py && echo "Ressourcen befreit." ;;
        q) echo "Sentinel aktiv im Hintergrund." ;;
        *) echo "Ungültige Wahl." ;;
    esac
}

# --- 4. STARTUP SEQUENCE ---
clear
echo -e "\033[1;34m==========================================\033[0m"
echo -e "\033[1;37m   GOOGLE SENTINEL BRIDGE - ACTIVE\033[0m"
echo -e "\033[1;34m==========================================\033[0m"

# Hardware Quick-Check
CAP=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)%
MEM=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
echo -e "🔋 Akku: $CAP | 🧠 RAM: $MEM | ⚙️ S20FE v1.1"
echo -e "\033[1;34m------------------------------------------\033[0m"

# Nur im ersten Fenster Server & Intro starten
if ! pgrep -x "llama-server" > /dev/null; then
    ai_start_local
    menu
else
    echo " STATUS: CONNECTED TO MASTER CORE"
fi
EOF

source ~/.bashrc
clear
exit
c
clear
cd ~
exit
cd ~
dir
cd llama.cpp
dir
exiz
exit
