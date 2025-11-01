#!/bin/bash
set -euo pipefail

# chemins
STATE_DIR="game_state/air"
LAB_ROOT_FILE="$STATE_DIR/lab_root.txt"
START_HMS_FILE="$STATE_DIR/depart.txt"
EXPECTED_OUT="$STATE_DIR/expected_pur.txt"
STARS_FILE="game_state/stars.txt"
CODE_EAU="game_state/code_air.txt"

# barème
LIMITE=1230
THREE_STAR_MAX=300
TWO_STAR_MAX=600
PENALITE=15

# fonction sec
hms_to_sec(){ IFS=: read -r h m s <<<"$1"; echo $((10#$h*3600+10#$m*60+10#$s)); }