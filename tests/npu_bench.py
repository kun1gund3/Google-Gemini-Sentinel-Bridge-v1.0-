import os
import subprocess
import time
import json

# Paths
MODEL_PATH = os.path.expanduser("~/models/qwen2-5-vl.gguf")
LLAMA_SERVER_PATH = os.path.expanduser("~/llama.cpp/build/bin/llama-server")
MEMORY_FILE = os.path.expanduser("~/.gemini/npu_config.json")

# Benchmarking Config
THREAD_CONFIGS = [2, 4, 6]
THERMAL_PATH = "/sys/class/thermal/thermal_zone0/temp"

def get_temp():
    try:
        with open(THERMAL_PATH, "r") as f:
            return int(f.read().strip()) / 1000
    except:
        return 0

def run_benchmark(threads):
    print(f"--- Benchmarking with {threads} threads ---")
    start_temp = get_temp()
    
    # Minimal run to measure latency
    cmd = [LLAMA_SERVER_PATH, "-m", MODEL_PATH, "-t", str(threads), "-n", "32", "--silent"]
    
    start_time = time.time()
    result = subprocess.run(cmd, capture_output=True, text=True)
    end_time = time.time()
    
    end_temp = get_temp()
    duration = end_time - start_time
    
    return {
        "threads": threads,
        "latency_sec": duration,
        "temp_delta": end_temp - start_temp,
        "final_temp": end_temp
    }

def main():
    results = []
    for t in THREAD_CONFIGS:
        results.append(run_benchmark(t))
    
    # Analyze Sweet Spot: Minimize Latency AND Temp Delta
    # Weighting: 70% latency, 30% temp
    best = min(results, key=lambda x: (x["latency_sec"] * 0.7) + (x["temp_delta"] * 0.3))
    
    print(f"\nOptimal configuration: {best}")
    
    # Save to agent memory
    with open(MEMORY_FILE, "w") as f:
        json.dump(best, f)
    print(f"Configuration saved to {MEMORY_FILE}")

if __name__ == "__main__":
    main()
