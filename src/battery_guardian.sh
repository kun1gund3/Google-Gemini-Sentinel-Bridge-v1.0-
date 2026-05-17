#!/data/data/com.termux/files/usr/bin/bash
# Sentinel Battery Guardian v1.3 (NPU-Integrated)
PORT=8085

# Hardware-Daten abgreifen
CAPACITY=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/battery/status 2>/dev/null)
TEMP=$(termux-sensor -s "Ambient temperature" -n 1 | jq -r '.[].values[0]' 2>/dev/null || echo "30")

# Lokale NPU-Entscheidung: Ist der Zustand kritisch?
DECISION=$(curl -s -X POST http://localhost:$PORT/completion \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": \"<|im_start|>system\nDu bist der Hardware-Beschützer. Analysiere: Akku $CAPACITY%, Status $STATUS, Temp $TEMP. Falls kritisch, gib eine kurze Warnung aus, sonst antworte 'OK'.<|im_end|>\n<|im_start|>assistant\n\", \"n_predict\": 20}" \
    | jq -r '.content')

# Sprachausgabe nur bei Anomalien
if [[ "$DECISION" != *"OK"* ]]; then
    echo -e "\033[1;31m[Battery-Alert]\033[0m $DECISION"
    bash ~/SentinelBridge/src/voice_sentinel.sh "$DECISION"
    # Log in das Gedächtnis
    sqlite3 ~/.gemini/security_audit.db "INSERT INTO agent_memory (observation, reflection) VALUES ('Battery Alert: $CAPACITY%', '$DECISION');"
fi
