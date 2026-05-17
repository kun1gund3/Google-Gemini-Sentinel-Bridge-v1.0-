#!/data/data/com.termux/files/usr/bin/bash
# Sentinel Visual Watchdog v1.2 - Clean Build
PORT=8085
echo -e "\033[1;35m[Vision-Sentinel]\033[0m Scanne Log-Strukturen..."

# Extrahiere Kontext für die lokale Inferenz
if [ -f "$HOME/v1_0_milestone.log" ]; then
    CONTEXT=$(tail -c 1000 "$HOME/v1_0_milestone.log" | tr -d '"' | tr -d '\n')
    curl -s -X POST http://localhost:$PORT/completion \
        -H "Content-Type: application/json" \
        -d "{\"prompt\": \"<|im_start|>system\nDu bist der technische Mentor. Analysiere das Log auf strukturelle Brüche: $CONTEXT<|im_end|>\n<|im_start|>assistant\n\", \"n_predict\": 60}" \
        | jq -r '.content'
fi
