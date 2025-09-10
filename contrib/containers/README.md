# SHAI en conteneur — guide simple

Conteneur **SHAI** isolé (lecture seule, no-new-privileges, caps droppées).  
Aucun provider LLM imposé : choisissez via `shai auth` (Ollama, OpenAI, Mistral…).

## Objectifs de conception
- Simplicité : un Dockerfile, un compose, un volume de configuration.
- Liberté de choix du provider : sélection dans `shai auth`.
- Sécurité par défaut : rootfs en lecture seule, `cap_drop: ALL`, `no-new-privileges`.
- Tests rapides et sans réseau.

---

## Prérequis
- Docker (ou Podman compatible Docker).

## Démarrage
```bash
docker compose -f contrib/containers/docker/compose.yml up -d
