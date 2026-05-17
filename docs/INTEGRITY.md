# Integrity Policy

Änderungen an diesem Repository sind nur nach erfolgreicher Validierung gegen den lokalen Hardware-Hash des S20FE zulässig.

## Validierungsprozess
Jeder Pull Request muss den lokalen Hash des S20FE-Host-Systems (basierend auf Hardware-ID und NPU-Konfiguration) beinhalten, um die Integrität und Kompatibilität mit der optimierten 6-Thread-Architektur zu gewährleisten. Änderungen ohne gültigen Hash werden als unsicher eingestuft und nicht gemergt.
2dc06bc14b5d196cb18edec36ccdcdd4b25f51d726ed2a825128bb2c4f2fde61  battery_guardian.sh
97cf76cea844f9767de1bd5f365cbac33a4c2909a7a2610cb91de355eb136ed7  visual_watchdog.sh
a77e41ad272f4fb98e569e0cf7650da3ff85d7ef31b3b3011f18e9549d57b80b  voice_sentinel.sh
