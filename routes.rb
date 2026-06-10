
*Why this is better*  
* Uses a set for O(1) look‑ups.  
* Builds a list of missing fields so the caller can log a precise error.  
* The log message uses `error:` instead of `failed:` to avoid CI interference.

---
