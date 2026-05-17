# Research Plan: v1.5 Predictive Health Guardian

## Overview
This experiment aims to transition SentinelBridge from reactive monitoring to proactive predictive maintenance by anticipating thermal anomalies on the S20FE device.

## Thermal Anomaly Definitions (S20FE)
- **Baseline (Idle):** 31°C
- **Performance (Load):** 38°C
- **Anomaly Threshold:** Any trend indicating a rate-of-change exceeding +2°C per 10 seconds while approaching the 38°C ceiling, or exceeding 42°C (Critical).

## Hardware History Data Structure (for `agent_memory`)
To facilitate training of the local predictive model, historical hardware states will be persisted in a JSON structure:

```json
{
  "timestamp_epoch": "long",
  "temperature_c": "float",
  "load_percentage": "float",
  "npu_active": "boolean",
  "is_anomaly": "boolean"
}
```

## Implementation Strategy
1.  Extend `sentinel_daemon` to log historical data points.
2.  Implement a local regression model to forecast temperatures.
3.  Develop the Proactive Throttling Controller.
