# Agent Skills: Persistent Memory
- **Database:** SQLite (~/.gemini/security_audit.db)
- **Table:** `agent_memory`
- **Logic:** Jede Interaktion wird in 'Observation' und 'Reflection' geteilt. 
  Vor jedem Cloud-Call wird der lokale Kontext injiziert.
