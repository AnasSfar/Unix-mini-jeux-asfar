#!/bin/bash
set -euo pipefail

state_dir="game_state/air"
lab="lab_air"
mkdir -p "$state_dir"
date +%H:%M:%S > "$state_dir/depart.txt"

clear
echo ""
echo "PORTE DE L'AIR — ÉPREUVE 3"
echo ""
echo "Le vent est prisonnier d’un labyrinthe invisible."
echo "Lis les couloirs dans l’ordre indiqué par les indices et libère-le."
echo ""
echo "Quand tu penses avoir fini, tu pourras lancer : ./verif_air.sh"
echo ""