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
