#!/data/data/com.termux/files/usr/bin/bash
# Sentinel Vision Bridge v1.1 - API Edition
PORT=8085
LOG_FILE="$HOME/v1_0_milestone.log"

if [ -f "$LOG_FILE" ]; then
    CONTEXT=$(cat "$LOG_FILE" | tr -d '\n' | cut -c1-1000)
    echo -e "\033[1;35m[Vision-Sentinel]\033[0m Analysiere Log-Strukturen via Sentinel-Bridge..."
    
    curl -s -X POST http://localhost:$PORT/completion \
        -H "Content-Type: application/json" \
        -d "{\"prompt\": \"<|im_start|>system\nDu bist der visuelle Mentor. Analysiere dieses Log auf Anomalien: $CONTEXT<|im_end|>\n<|im_start|>assistant\n\", \"n_predict\": 50}" \
        | jq -r '.content'
else
    echo "Log-Datei nicht gefunden."
fi
