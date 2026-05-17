#!/bin/bash
# Security Patcher
# Weekly automated audit and patcher

TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S")
echo "Starting security audit: $TIMESTAMP"

# Audit and attempt automatic fixes
npm audit --prefix .gemini fix > security_audit.log 2>&1

# Log success
sqlite3 .gemini/security_audit.db "INSERT INTO agent_memory (timestamp, observation, reflection) VALUES ('$TIMESTAMP', 'Security Patching', 'Weekly audit completed. Check logs in security_audit.log');"

echo "Audit completed. Check security_audit.log"
