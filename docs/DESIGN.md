# System Design
- **Frontend:** Gemini CLI v0.42.0.
- **Backend:** llama-server (Port 8888) auf aarch64.
- **Data-Flow:** User -> ai() -> local_check -> SQLite -> Cloud-Inquiry -> Blackbox-Log.
