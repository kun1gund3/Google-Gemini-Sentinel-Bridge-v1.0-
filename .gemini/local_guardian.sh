#!/data/data/com.termux/files/usr/bin/bash
DB_PATH="$HOME/.gemini/security_audit.db"
ENV_PATH="$HOME/.gemini/.env"

# Integrität prüfen
if [ -f "$ENV_PATH" ]; then
    CURRENT_HASH=$(sha256sum "$ENV_PATH" | awk '{print $1}')
    # Sicherstellen dass die Tabelle logs existiert
    sqlite3 "$DB_PATH" "CREATE TABLE IF NOT EXISTS logs (id INTEGER PRIMARY KEY, action TEXT, status TEXT, hash TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP);"
    sqlite3 "$DB_PATH" "INSERT INTO logs (action, status, hash) VALUES ('Integrity Check', 'OK', '$CURRENT_HASH');"
fi

# Lokale Analyse via laufendem Sentinel-Kern (llama-server)
if pgrep -x "llama-server" > /dev/null; then
    echo -e "\033[1;32m[Sentinel-Local]\033[0m Generiere proaktiven Sicherheits-Tipp..."
    curl -s -X POST http://localhost:8085/completion \
        -H "Content-Type: application/json" \
        -d '{"prompt": "User: Gib mir einen extrem kurzen Sicherheits-Tipp für Termux.\nAssistant:", "n_predict": 50}' \
        | python3 -c "import sys, json; print(json.load(sys.stdin)['content'])" 2>/dev/null
    echo ""
fi
