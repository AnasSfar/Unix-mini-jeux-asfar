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
echo "Cher voyaguer, le vent est prisonnier d’un labyrinthe invisible."
echo "Lis les couloirs dans l’ordre indiqué par les indices et libère-le."
echo ""
echo "Quand tu penses avoir fini, tu pourras lancer : ./verif_air.sh"
echo "Tu as 20 minutes pour libérer l'air."

# labyrinthe
rm -rf "$lab" #supprime tout ancien labyrinthe
mkdir -p "$lab"

# cle du vent
echo "Souffle captif." > "$lab/cle.txt"

# couloirs
cat > "$lab/nord.txt" <<'TXT'
[NORD]
Le vent se cache dans les ombres.
Révèle ce qui est invisible dans ce dossier pour entendre son premier souffle = ton premier indice.
(indice : affiche aussi les fichiers cachés)
TXT

cat > "$lab/sud.txt" <<'TXT'
[SUD]
L’air est brûlant ici.
Crée-lui un passage plus frais nommé « brise », puis cherche plus loin vers l’EST.
(indice : crée un dossier)
TXT

cat > "$lab/est.txt" <<'TXT'
[EST]
Un passage existe, mais la clé du vent n’y est pas encore.
Déplace la clé (cle.txt) dans le couloir « brise » et renomme-la « air.txt ».
Quand ce sera fait, le vent te parlera à l’OUEST.
(indice : déplace et renomme en une seule action)
TXT

cat > "$lab/ouest.txt" <<'TXT'
[OUEST]
Dernière étape : transforme l’air lui-même.
Ouvre « lab_air/brise/air.txt » et ajoute à la fin la phrase exacte :
Le vent est libre.
Quand ton chant est complet, lance : ./verif_air.sh
(indice : ajoute du texte avec un éditeur… ou directement en ligne de commande)
TXT

# indice caché après NORD
echo "Le vent descend vers le SUD. Lis sud.txt" > "$lab/.indice.txt"

# etat pour verif
echo "$lab" > "$state_dir/lab_root.txt"
printf '%s\n' "Le vent est libre." > "$state_dir/expected_phrase.txt"

# depart
echo "Commence par : cat $lab/nord.txt"
echo "(Astuce : certains indices sont cachés…)"
echo ""