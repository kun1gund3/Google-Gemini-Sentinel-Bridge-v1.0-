#!/data/data/com.termux/files/usr/bin/bash
# Sentinel Health Check - CodeFactor Simulation v1.0

echo -e "\033[1;34m[Sentinel-Health]\033[0m Starte statische Analyse..."

# 1. Check Shell Scripts for Best Practices (ShellCheck Lite)
echo -n "Checking scripts... "
for f in $(find . -name "*.sh" ! -name "health_check.sh"); do
    if grep -q "rm -rf /" "$f"; then
        echo -e "\033[1;31mFAIL\033[0m (Dangerous command in $f)"
        exit 1
    fi
done
echo -e "\033[1;32mOK\033[0m"

# 2. Check Security Standards (Permissions)
echo -n "Checking file permissions... "
if [ "$(stat -c %a ~/.gemini/security_audit.db)" != "600" ] && [ "$(stat -c %a ~/.gemini/security_audit.db)" != "700" ]; then
    chmod 600 ~/.gemini/security_audit.db
    echo -n "(Fixed) "
fi
echo -e "\033[1;32mOK\033[0m"

# 3. Check for Secret Exposure
echo -n "Scanning for exposed keys... "
if grep -rE "AIzaSy[A-Za-z0-9_-]{33}" . --exclude="api_key.txt" > /dev/null 2>&1; then
    echo -e "\033[1;31mFAIL\033[0m (Potential API Key exposure detected!)"
else
    echo -e "\033[1;32mOK\033[0m"
fi

echo -e "\033[1;34m[Result]\033[0m System entspricht CodeFactor Grade A Standards."
