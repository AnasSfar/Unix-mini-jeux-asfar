#!/bin/bash

set -euo pipefail

# On doit avoir la bonne réponse stockée par ./fire
if [[ ! -f .bonne_reponse ]]; then
  echo "⚠️  Aucune énigme en cours. Lance d'abord : ./fire"
  exit 1
fi

bonne="$(cat .bonne_reponse)"

# Normalisation (minuscules + trim)
norm() { echo "$1" | tr '[:upper:]' '[:lower:]' | xargs; }

echo
echo "🔥 La flamme crépite et attend ton verdict…"
read -rp "👉 Donne-moi la réponse, cher joueur : " rep

# Sortie volontaire
if [[ "$(norm "$rep")" == "out" ]]; then
  echo "💨 Tu t'éloignes du brasier. Vérification annulée."
  exit 0
fi

if [[ "$(norm "$rep")" == "$(norm "$bonne")" ]]; then
  echo "✔️ Bonne réponse ! 🔥 La flamme te reconnaît."
  exit 0
else
  echo "❌ Mauvaise réponse. 🪵 La braise reste muette."
  exit 1
fi
