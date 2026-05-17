# --- IDENTITÄT & KEYS ---
export GEMINI_API_KEY=$(cat ~/.gemini/api_key.txt 2>/dev/null)
export GOOGLE_API_KEY=$GEMINI_API_KEY
export GEMINI_CLI_TRUST_WORKSPACE=true

# --- SENTINEL LOCAL SERVER ---
ai_start_local() {
    if ! pgrep -x "llama-server" > /dev/null; then
        echo -e "\033[1;34m[Sentinel]\033[0m Initialisiere lokalen Kern..."
        $HOME/llama.cpp/build/bin/llama-server \
            -m $HOME/models/local_partner.gguf \
            --port 8082 --ctx-size 256 --threads 4 --log-disable > /dev/null 2>&1 &
        sleep 2
    fi
}

# --- DER PARTNER BEFEHL (GOLDEN STATE) ---
ai() {
    ai_start_local
    
    # 1. Lokaler Vorab-Check (Schnell & Offline)
    echo -e "\033[1;32m[Hermes-Local]\033[0m Analyse läuft..."
    curl -s -X POST http://localhost:8082/completion \
        -H "Content-Type: application/json" \
        -d "{\"prompt\": \"<|im_start|>system\nDu bist der Beschützer. Kurze Anweisung für: $*\n<|im_end|>\n<|im_start|>assistant\n\", \"n_predict\": 20}" \
        | python3 -c "import sys, json; print(json.load(sys.stdin)['content'])" 2>/dev/null

    echo -e "------------------------------------------"

    # 2. Cloud-Mentor (Zwang auf stabiles 1.5-Flash)
    # Wir fangen den 429-Fehler ab
    gemini --model gemini-1.5-flash --approval-mode default -p "$*" || \
    echo -e "\033[1;31m[System-Info]\033[0m Cloud-Quota erreicht. Nutze Hermes lokal für weitere Befehle."
}

clear
echo "=========================================="
echo " GOOGLE SENTINEL - GOLDEN STATE AKTIV"
echo " STATUS: HYBRIDE AUTONOMIE (REVISIONS-SICHER)"
echo "=========================================="
