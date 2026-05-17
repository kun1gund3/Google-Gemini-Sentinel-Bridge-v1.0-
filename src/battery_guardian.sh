#!/data/data/com.termux/files/usr/bin/bash
# Sentinel Battery Guardian v1.3 - Real-Time Edition
HW_STATE="$HOME/.gemini/hw_state.json"

if [ -f "$HW_STATE" ]; then
    # Blitzschnelles Lesen aus dem JSON-Puffer
    CAPACITY=$(jq -r '.capacity' "$HW_STATE")
    
    # Lokale Logik: Warnung bei unter 20%
    if [ "$CAPACITY" -lt 20 ]; then
        MSG="Warnung Partner: Akku kritisch bei $CAPACITY%. System-Drosselung empfohlen."
        echo -e "\033[1;31m[Sentinel]\033[0m $MSG"
        bash ~/SentinelBridge/src/voice_sentinel.sh "$MSG"
    else
        echo -e "\033[1;32m[Sentinel]\033[0m Energie-Status stabil: $CAPACITY%"
    fi
else
    echo "Hardware-Puffer nicht gefunden. Startet Sentinel-Daemon..."
    ~/SentinelBridge/build/sentinel_daemon &
fi
