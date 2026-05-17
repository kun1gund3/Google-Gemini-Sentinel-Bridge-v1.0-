#!/data/data/com.termux/files/usr/bin/bash
# Sentinel GitHub Link Provider v1.3.1
echo -e "\033[1;34m[Sentinel-Push]\033[0m Synchronisiere v1.4..."
OUTPUT=$(git push origin main --force 2>&1)
echo "$OUTPUT"
PR_LINK=$(echo "$OUTPUT" | grep -o 'https://github.com/[^ ]*/pull/new/[^ ]*')
if [ ! -z "$PR_LINK" ]; then
    echo -e "\n\033[1;32m[Sentinel-Link]\033[0m PR bereit: $PR_LINK"
    termux-open "$PR_LINK"
fi
