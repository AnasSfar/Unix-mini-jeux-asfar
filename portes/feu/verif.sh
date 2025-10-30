#!/bin/bash

STATE_DIR="./game_state/feu"
EXPECTED_FILE="$STATE_DIR/expected_answer.txt"
LAB_ROOT_FILE="$STATE_DIR/lab_root.txt"

if [[ ! -f "$EXPECTED_FILE" || ! -f "$LAB_ROOT_FILE" ]]; then
  echo "⚠️  Aucune énigme active. Lance d'abord l'épreuve du FEU."
  exit 1
fi

expected="$(<"$EXPECTED_FILE")"
lab_root="$(<"$LAB_ROOT_FILE")"

# --- Fonction de normalisation ---
normalize() {
  local s="$*"
  if command -v iconv >/dev/null 2>&1; then
    s="$(printf '%s' "$s" | iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null || printf '%s' "$s")"
  fi
  printf '%s' "$s" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+//g'
}

expected_norm="$(normalize "$expected")"
candidate="$lab_root/$expected_norm"

# --- Vérification ---
if [[ -f "$candidate" ]]; then
  echo "✔️  Bonne réponse ! Tu as trouvé le fichier '$expected_norm'. 🔥"
  echo "✅ Épreuve du FEU réussie !"
  exit 0
else
  echo "❌  Aucun fichier nommé '$expected_norm' trouvé à la racine du labyrinthe."
  echo "💡 Vérifie que tu l’as bien créé dans : $lab_root"
  exit 1
fi
