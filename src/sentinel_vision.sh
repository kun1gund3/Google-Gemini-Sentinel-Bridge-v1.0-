#!/data/data/com.termux/files/usr/bin/bash
# Sentinel Vision Engine v1.4
IMAGE_PATH=$1
PORT=8085

if [ -z "$IMAGE_PATH" ]; then
    echo -e "\033[1;31m[Vision-Error]\033[0m Kein Bildpfad angegeben."
    exit 1
fi

echo -e "\033[1;35m[Vision-Sentinel]\033[0m Analysiere visuelle Daten lokal auf NPU/GPU..."

# Sende Bildpfad an den lokalen Inferenz-Kern
# Hinweis: Qwen2.5-VL nutzt ein spezielles Format für Bild-Injektionen
curl -s -X POST http://localhost:$PORT/completion \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": \"<|im_start|>system\nDu bist der visuelle Mentor. Analysiere dieses Bild auf Sicherheitsrisiken oder Systemfehler.<|im_end|>\n<|im_start|>user\n[IMAGE]: $IMAGE_PATH\n<|im_end|>\n<|im_start|>assistant\n\", \"n_predict\": 150}" \
    | jq -r '.content'
