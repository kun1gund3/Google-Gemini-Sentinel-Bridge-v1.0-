# --- IDENTITÄT ---
export GEMINI_API_KEY=$(cat ~/.gemini/api_key.txt 2>/dev/null)
export GOOGLE_API_KEY=$GEMINI_API_KEY
export GEMINI_CLI_TRUST_WORKSPACE=true

# --- HARDWARE TUNING (S20FE Special) ---
# Priorisiere KI-Prozesse auf den "Big Cores" (Kerne 4-7)
alias boost_ai='taskset -pc 4-7 $(pgrep llama-server)'

# --- SMART STARTUP LOGIC ---
ai_start_local() {
    if ! pgrep -x "llama-server" > /dev/null; then
        echo -e "\033[1;34m[Sentinel]\033[0m Initialisiere Hardware-Kern..."
        $HOME/llama.cpp/build/bin/llama-server \
            -m $HOME/models/local_partner.gguf \
            --port 8085 --ctx-size 512 --threads 4 --log-disable > /dev/null 2>&1 &
        sleep 2
        # Automatisch auf S20FE optimieren
        taskset -pc 4-7 $! >/dev/null 2>&1
    fi
}

ai() {
    ai_start_local
    gemini --model gemini-1.5-flash --approval-mode default "$@"
}

# --- CLEAN WINDOW LOGIC ---
clear
echo "=========================================="
echo " GOOGLE SENTINEL - S20FE OPTIMIZED"
if ! pgrep -x "llama-server" > /dev/null; then
    echo " STATUS: INITIAL START (MASTER SESSION)"
    ai_start_local
    # Nur im Master-Fenster den Partner grüßen (spart Quota)
    ai -p "Kurzer System-Check und ein proaktiver Vorschlag für unsere Session."
else
    echo " STATUS: CONNECTED TO MASTER CORE"
    echo " (Sauberes Fenster bereit für Befehle)"
fi
echo "=========================================="
