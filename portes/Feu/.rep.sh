#!/bin/bash
# Usage: .rep.sh reponse_joueur bonne_reponse

reponse=$(echo "$1" | tr '[:upper:]' '[:lower:]')
bonne=$(echo "$2" | tr '[:upper:]' '[:lower:]')

if [[ "$reponse" == "$bonne" ]]; then
    echo "✔️  Bonne réponse !"
    exit 0
else
    echo "❌  Mauvaise réponse..."
    exit 1
fi
