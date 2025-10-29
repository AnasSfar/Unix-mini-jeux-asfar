#!/bin/bash
set -euo pipefail

#temps et score :
limite=900         # temps max (15 minutes)
penalite=30        # +30 s à chaque mauvaise réponse
total_penalites=0  # cumul des pénalités
debut=$(date +%s)  # temps de départ

# ---
clear
echo "        🔥 PORTE DU FEU — EPREUVE 1 🔥"
echo ""
echo "Bienvenue, voyageur..."
echo "Tu viens d’ouvrir la Porte du Feu, gardienne de la flamme éternelle."
echo ""
echo "Pour que la flamme te reconnaisse, tu devras prouver ta maîtrise du Feu :"
echo "  🔸 Cherche le fichier sacré dont le nom t’est révélé."
echo "  🔸 Lis-y l’énigme cachée entre les braises."
echo "  🔸 Réponds avant que la flamme ne s’éteigne (15 minutes)."
echo ""
echo "⏱  Tant que le temps s’écoule... la flamme faiblit..."
echo "Tape OUT si tu veux renoncer et quitter cette épreuve."
echo ""
sleep 3

# --- Création du labyrinthe ---
lab="lab_feu"
rm -rf "$lab"
mkdir -p "$lab"/{combustible/{bois,papier},comburant/{air,oxygene},energie/{etincelle,friction}}

# --- Choix aléatoire d'un emplacement ---
dossiers=($(find "$lab" -type d))
fichier="${dossiers[$RANDOM % ${#dossiers[@]}]}/flamme.txt"

# --- Liste des énigmes et réponses ---
enigmes=(
  "Énigme FEU : Je nais de l'étreinte de l'air et du bois. Qui suis-je ?"
  "Énigme FEU : Plus je suis chaude, plus je deviens bleue. Quelle est ma couleur ?"
  "Énigme FEU : Je reste quand tout brûle. Qui suis-je ?"
)
reponses=("feu" "bleu" "cendre")

i=$((RANDOM % ${#enigmes[@]}]))
enigme="${enigmes[$i]}"
bonne="${reponses[$i]}"

# --- Message au joueur ---
echo "🎯 Le fichier mystère s'appelle : flamme.txt"
echo "💡 Explore le labyrinthe : cd lab_feu"
echo "🔥 Que la flamme te guide..."
