# SHai en conteneur

Conteneur **SHai** isolé (lecture seule, no-new-privileges, caps droppées).  
Aucun provider LLM imposé : choisissez via `shai auth` (Ollama, OpenAI, Mistral…).

---

## Prérequis
- Docker (ou Podman compatible Docker).

## Démarrage
```bash
docker compose -f contrib/containers/docker/compose.yml up -d
