#!/data/data/com.termux/files/usr/bin/bash
# Meldet kritische Systemzustände akustisch
MESSAGE=$1
termux-tts-speak -l de-DE -r 1.1 -p 1.0 "$MESSAGE"
