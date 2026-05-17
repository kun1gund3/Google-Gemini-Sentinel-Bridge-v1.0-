#!/bin/bash
# Deployment & Verification Script (v1.7)

TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S")

echo "--- Sentinel-Bridge Deployment v1.7 ---"
echo "Timestamp: $TIMESTAMP"

# 1. Check Security Patcher status
LAST_PATCH=$(sqlite3 .gemini/security_audit.db "SELECT timestamp FROM agent_memory WHERE observation='Security Patching' ORDER BY id DESC LIMIT 1;")

if [ -z "$LAST_PATCH" ]; then
    echo "[WARNING] No security patch found in history."
else
    echo "[INFO] Last security patch applied: $LAST_PATCH"
fi

# 2. Run Patcher
bash SentinelBridge/src/security_patcher.sh

echo "--- Deployment Complete ---"
