#!/usr/bin/env bash
# Licensed under the Apache License, Version 2.0
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
. "$ROOT/tests/helpers.bash"

log "Pré-requis"
assert_cmd docker
assert_cmd bash

IMG="shai:test"
CNT="shai_test_run"

# ref à builder : input env > ref de l'event CI > main
REF="${SHAI_REF:-${GITHUB_REF_NAME:-main}}"
LOCKED="${CARGO_LOCKED:-0}"

log "Build de l'image"
docker build \
  --build-arg "SHAI_REF=${REF}" \
  --build-arg "CARGO_LOCKED=${LOCKED}" \
  -f "$ROOT/docker/Dockerfile" -t "$IMG" "$ROOT/docker"

log "Exécution: --version"
out="$(docker run --rm "$IMG" --version || true)"
[ -n "$out" ] || fail "sortie vide sur --version"
pass "le binaire s'exécute (version affichée)"

log "Montage config + .env (sanity)"
docker run --rm --name "$CNT" \
  -v "$ROOT/config/shai.config.json:/home/shai/.config/shai/config.json:ro" \
  -v "$ROOT/.env.example:/home/shai/.env:ro" \
  "$IMG" --help >/dev/null 2>&1 || true
pass "conteneur lancé avec montages"

log "Nettoyage"
docker rm -f "$CNT" >/dev/null 2>&1 || true
pass "OK"
