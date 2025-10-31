#!/bin/bash

# chemins
STATE_DIR="game_state/feu"
EXPECTED_FILE="$STATE_DIR/expected_answer.txt"
LAB_ROOT_FILE="$STATE_DIR/lab_root.txt"
START_HMS_FILE="$STATE_DIR/depart.txt"
STARS_FILE="game_state/stars.txt"
SYMS_FILE="game_state/symbols.txt"
CODE_FEU="game_state/code_feu.txt"

# barème
THREE_STAR_MAX=90
TWO_STAR_MAX=180
PENALITE=15  # +15 s / erreur

# vérif fichiers
if [[ ! -f "$EXPECTED_FILE" || ! -f "$LAB_ROOT_FILE" ]]; then
  echo "⚠️ Lance d'abord l'épreuve du FEU."
  exit 1
fi

# lecture
expected="$(<"$EXPECTED_FILE")"
lab_root="$(<"$LAB_ROOT_FILE")"
candidate="$lab_root/$expected"

# erreurs
total_files=$(find "$lab_root" -maxdepth 1 -type f | wc -l)
if [[ -f "$candidate" ]]; then
  errors=$(( total_files > 0 ? total_files - 1 : 0 ))
else
  errors=$total_files
fi

# si pas trouvé
if [[ ! -f "$candidate" ]]; then
  echo "❌ Fichier '$expected' absent dans $lab_root"
  echo "❌ Erreurs : $errors"
  exit 1
fi

# temps (HH:MM:SS → s)
hms_to_sec(){ IFS=: read -r h m s <<<"$1"; echo $((10#$h*3600+10#$m*60+10#$s)); }
if [[ -f "$START_HMS_FILE" ]]; then
  start_hms="$(<"$START_HMS_FILE")"
  now_hms="$(date +%H:%M:%S)"
  start_s=$(hms_to_sec "$start_hms")
  now_s=$(hms_to_sec "$now_hms"); (( now_s < start_s )) && now_s=$((now_s+86400))
  temps=$(( now_s - start_s ))
else
  temps=9999
fi

# appliquer pénalité
total=$(( temps + errors * PENALITE ))

# étoiles
if   (( total <= THREE_STAR_MAX )); then stars=3
elif (( total <= TWO_STAR_MAX ));  then stars=2
else                                stars=1
fi

# chiffre aléatoire 0–9
digit=$(( RANDOM % 10 ))

# enregistrements
mkdir -p game_state
echo "FEU:$stars" >> "$STARS_FILE"
echo "$digit" > "$CODE_FEU"

# résumé
echo "Bonne réponse : '$expected'"
echo "Temps brut : ${temps}s"
echo "Erreurs : ${errors}  (+$((errors*PENALITE))s)"
echo "Étoiles : ${stars}"
echo " Ton code secret pour l'épreuve du feu est : ${digit}"

