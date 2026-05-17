# Sentinel Bridge (v1.1)

## Architecture
Die Sentinel-Bridge bildet das Rückgrat unseres Systems. Sie orchestriert Inferenz-Tasks, überwacht Systemparameter und sorgt für die Stabilität auf dem Samsung S20FE.

### S20FE Optimierung
Unser System nutzt eine dedizierte Konfiguration für das S20FE, die durch Benchmarks (npu_bench.py) als optimal validiert wurde:
- **Thread-Konfiguration:** 6 Threads (bester Kompromiss aus Latenz und thermischer Last).
- **Prozess-Management:** Alle Hardware-intensiven Prozesse werden bei Start mit `cd ~` initiiert, um Pfad-Konflikte zu vermeiden.

## Projektstruktur
- `/src`: Kernlogik und Sentinel-Skripte.
- `/docs`: Dokumentation und Architektur-Referenzen.
- `/tests`: Benchmarks und Validierungsskripte.
