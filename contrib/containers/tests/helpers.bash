#!/usr/bin/env bash
# Licensed under the Apache License, Version 2.0
set -euo pipefail

log()   { printf "\n\033[1m➡ %s\033[0m\n" "$*"; }
pass()  { printf "\033[32m✔ %s\033[0m\n" "$*"; }
fail()  { printf "\033[31m✘ %s\033[0m\n" "$*"; exit 1; }

assert_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "commande manquante: $1"
  pass "commande dispo: $1"
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  grep -qF -- "$needle" <<<"$haystack" || fail "attendu: '$needle'"
  pass "contient: $needle"
}
