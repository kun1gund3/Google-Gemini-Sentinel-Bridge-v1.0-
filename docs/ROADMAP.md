# Sentinel-Bridge Project Roadmap

## v1.0 (Completed)
- [x] Initial system setup & stability audit (Grade A).
- [x] Optimization for S20FE (UFS 3.1).
- [x] Core health check implementation.

## v1.1 (In Progress)
- [x] **GPU-OpenCL-Acceleration Strategy:**
    - [x] Verify GPU driver access via `gpu_probe`.
    - [x] Configure `CLBlast` and `OpenCL` environment for Adreno 650.
    - [x] Integrate `CLBlast` into `llama-server` build.
    - [x] Validate GPU offloading performance. (Verification in progress)
- [ ] Benchmarking & Optimization:
    - [ ] Target: < 100ms inference for local Wächter.
    - [ ] Profile performance bottlenecks.

## v1.2 (Active - Alpha)
- [x] Deployment refinement & UI integration (using existing `tools/ui`).
- [x] Visual Watchdog correction & Voice integration (Audit Log monitoring).

## v1.3 (Completed - Zero-Latency Bridge)
- [x] **Hardware-API Optimierung:**
    - [x] Implementieren eines Puffer-Mechanismus für `termux-api` Aufrufe zur Eliminierung von Timeouts.
    - [x] Asynchrone Datenverarbeitung für Sensor-Daten.
    - [x] Optimierung der `visual_watchdog.sh` und `battery_guardian.sh` für geringere Latenz.
- [x] Architektur-Review für Echtzeit-Performance.

## v1.4 (In Progress - Alpha)
- [ ] **Vision-Integration:**
    - [ ] Implement secure visual data handling protocol.
    - [ ] Automated screenshot auditing system (`src/screenshot_audit.py`).
