# Integrity Policy

Änderungen an diesem Repository sind nur nach erfolgreicher Validierung gegen den lokalen Hardware-Hash des S20FE zulässig.

## Validierungsprozess
Jeder Pull Request muss den lokalen Hash des S20FE-Host-Systems (basierend auf Hardware-ID und NPU-Konfiguration) beinhalten, um die Integrität und Kompatibilität mit der optimierten 6-Thread-Architektur zu gewährleisten. Änderungen ohne gültigen Hash werden als unsicher eingestuft und nicht gemergt.
