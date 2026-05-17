import json
import os
import subprocess

# Pfade
HISTORY_FILE = os.path.expanduser("~/.gemini/hw_history.jsonl")
VOICE_SCRIPT = os.path.expanduser("~/SentinelBridge/src/voice_sentinel.sh")

def get_last_entries(n=10):
    if not os.path.exists(HISTORY_FILE):
        return []
    with open(HISTORY_FILE, 'r') as f:
        lines = f.readlines()
        return [json.loads(line) for line in lines[-n:]]

def run_thermal_predictor():
    entries = get_last_entries(10)
    if len(entries) < 2:
        return

    # Lineare Regression (Trendberechnung)
    t1, temp1 = entries[0]['timestamp'], entries[0]['temperature_c']
    t2, temp2 = entries[-1]['timestamp'], entries[-1]['temperature_c']
    
    delta_t = t2 - t1
    if delta_t == 0: return
    
    slope = (temp2 - temp1) / delta_t  # Grad pro Sekunde
    
    # Vorhersage für in 5 Minuten (300 Sek)
    projected_temp = temp2 + (slope * 300)
    
    if projected_temp > 38.0:
        msg = f"Achtung Partner: Thermische Anomalie vorhergesagt. Erwartete Temperatur: {projected_temp:.1f} Grad."
        print(f"\033[1;31m[Sentinel-Predictor]\033[0m {msg}")
        subprocess.run(["bash", VOICE_SCRIPT, msg])

if __name__ == "__main__":
    run_thermal_predictor()
