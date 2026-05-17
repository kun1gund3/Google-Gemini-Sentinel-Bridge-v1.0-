# Real-Time Integrity Standard (Timestamps)

## Overview
This document defines the mandatory standard for maintaining repository integrity through synchronized, verifiable timestamps across all system components.

## Policy
1. **Source of Truth:** All system timestamps must be synchronized with the local hardware clock (`hw_state.json`) or a trusted NTP peer within the local network context.
2. **Divergence Tolerance:** Git commit timestamps must not diverge by more than 500ms from the synchronized system time during automated push operations.
3. **Verification:** The `Real-Time Push Engine` must validate timestamp consistency before every remote synchronization.
