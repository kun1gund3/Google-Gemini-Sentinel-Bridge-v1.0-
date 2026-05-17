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

## v1.3 (Planned - Next Mission)
- [ ] **Echtzeit-Akku-Sprachwarnung via NPU-Überwachung:**
    - [ ] Implementieren einer NPU-gestützten Batterie-Monitor-Schleife.
    - [ ] Integration von `voice_sentinel.sh` für kritische Spannungs-Warnungen.
