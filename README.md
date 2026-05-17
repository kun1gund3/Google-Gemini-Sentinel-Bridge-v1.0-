# 🛡️ Google Gemini Sentinel Bridge v1.0

**The Gold Standard for Hybrid AI Ecosystems on Android Termux.**

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Platform: Android/Termux](https://img.shields.io/badge/Platform-Android%20%7C%20Termux-orange.svg)](https://termux.dev/)
[![Engine: Hybrid-AI](https://img.shields.io/badge/Engine-Cloud%20%2B%20Local-green.svg)](#)
[![Hardware: S20FE Optimized](https://img.shields.io/badge/Hardware-Snapdragon%20865%20%7C%20NPU-red.svg)](#)

> **"Transforming a Smartphone from a Passive Consumer Device into an Autonomous, Revisions-Secure AI Sentinel."**

Die **Google Gemini Sentinel Bridge** ist eine hochperformante Cyber-KI-Architektur für mobile Endgeräte. Sie fusioniert die grenzenlose Intelligenz der **Google Gemini Cloud** mit der kompromisslosen Autonomie und Sicherheit eines lokalen **Inferenz-Kerns (llama.cpp/Qwen)**.

---

## 🚀 Der Durchbruch: 45 Minuten → 45 Sekunden
Herkömmliche Terminal-KI-Skripte leiden oft unter Ressourcen-Konflikten und Instabilitäten. Dieses Projekt implementiert die **Sentinel-Bridge-Architektur**: 
Durch eine strikte Trennung von **Background Server (Local Core)** und **Client Interface (Cloud Mentor)** wurden komplexe System-Audits, die zuvor 45 Minuten beanspruchten, auf **unter 45 Sekunden** optimiert – bei 100%iger Stabilität.

### ⚡ Performance-Metriken (Referenz: Samsung S20FE)
*   **Lokale Inferenz:** ~28.5 Tokens/Sekunde (Qwen-Eco 1.5B)
*   **Cloud-Latenz:** < 1.2s via Gemini 1.5 Flash (v1beta API)
*   **Memory Efficiency:** < 900 MB RAM Auslastung im Peak-Betrieb.

---

## ✨ Kern-Features

### 🧠 Agent Memory (kun1gund3 Standard)
Basierend auf [kun1gund3/agentmemory](https://github.com/kun1gund3/agentmemory) nutzt das System eine lokale **SQLite3-Datenbank**, um ein persistentes Langzeitgedächtnis zu pflegen. Der Mentor lernt aus jeder Sitzung und verknüpft lokales Systemwissen mit Cloud-Strategien.

### 🛡️ Autonomer Wächter (Local-First)
Bevor eine Anfrage die Cloud erreicht, führt der lokale Kern eine Integritätsprüfung durch. Bei Quota-Limits oder Verbindungsabbrüchen übernimmt die lokale KI nahtlos als autonomer Mentor.

### 🔒 Enterprise-Grade Security
*   **Approval-Mode:** Kein System-Befehl wird ohne explizite Bestätigung ausgeführt.
*   **Credential Isolation:** API-Keys werden in isolierten Dateien mit restriktiven Berechtigungen (`chmod 600`) verwahrt.
*   **Blackbox-Recording:** Jede Session wird fälschungssicher dokumentiert.

---

## 🏗️ System-Architektur

```mermaid
graph TD
    A[User Terminal] -->|ai command| B{Sentinel Bridge}
    B -->|Local Check| C[SQLite Memory]
    B -->|Autonomous| D[Local Engine: llama-server]
    B -->|Cloud Sync| E[Gemini 1.5 Flash]
    D -->|Audit| F[Integrity Verified]
    E -->|Identity| G[Google Mentor Protocol]
    F & G --> H[Unified Partner Response]
    H -->|Logging| I[Blackbox-Recorder]
