#!/bin/bash
set -euo pipefail

# chemins
STATE_DIR="game_state/feu"
EXPECTED_FILE="$STATE_DIR/expected_answer.txt"
LAB_ROOT_FILE="$STATE_DIR/lab_root.txt"
START_HMS_FILE="$STATE_DIR/depart.txt"
STARS_FILE="game_state/stars.txt"
CODE_FEU="game_state/code_feu.txt"

# barème
LIMITE=900          # temps max (15 min)
THREE_STAR_MAX=90
TWO_STAR_MAX=180
PENALITE=15

# fonctions utilitaires
hms_to_sec(){ IFS=: read -r h m s <<<"$1"; echo $((10#$h*3600+10#$m*60+10#$s)); }

# vérifs fichiers
[[ -f "$EXPECTED_FILE" && -f "$LAB_ROOT_FILE" ]] || { echo "⚠️ Lance d'abord l'épreuve du FEU."; exit 1; }

# lecture
expected="$(<"$EXPECTED_FILE")"
lab_root="$(<"$LAB_ROOT_FILE")"
candidate="$lab_root/$expected"

# erreurs (fichiers à la racine ≠ bonne réponse)
total_files=$(find "$lab_root" -maxdepth 1 -type f | wc -l)
if [[ -f "$candidate" ]]; then
  errors=$(( total_files > 0 ? total_files - 1 : 0 ))
else
  errors=$total_files
fi

# temps écoulé
temps=9999
if [[ -f "$START_HMS_FILE" ]]; then
  s1=$(hms_to_sec "$(cat "$START_HMS_FILE")")
  s2=$(hms_to_sec "$(date +%H:%M:%S)")
  (( s2 < s1 )) && s2=$((s2+86400))
  temps=$(( s2 - s1 ))
fi

# si limite dépassée → fin du jeu
if (( temps > LIMITE )); then
  echo "⏰ Le temps imparti est écoulé (${temps}s > ${LIMITE}s)."
  echo "🔥 La flamme s'éteint... Épreuve du FEU échouée."
  exit 1
fi

# si la réponse est absente → échec
if [[ ! -f "$candidate" ]]; then
  echo "❌ Fichier '$expected' non trouvé dans $lab_root."
  echo "❌ Erreurs : $errors"
  exit 1
fi

# calcul du score (temps + pénalités)
total=$(( temps + errors * PENALITE ))
if   (( total <= THREE_STAR_MAX )); then stars=3
elif (( total <= TWO_STAR_MAX ));  then stars=2
else                                stars=1
fi

# chiffre aléatoire
digit=$(( RANDOM % 10 ))

# enregistrement
mkdir -p game_state
echo "FEU:$stars" >> "$STARS_FILE"
echo "$digit" > "$CODE_FEU"

# résumé
echo "✔️ Bonne réponse !"
echo "⏱️ Temps : ${temps}s  + ${errors}×${PENALITE}s  → total=${total}s"
echp " Erreurs : 
echo "⭐ Étoiles : ${stars}"
echo "🔢 Chiffre du FEU : ${digit}"
echo "🔥 Épreuve du FEU réussie !"