#!/bin/bash
set -euo pipefail

#temps et score :
CAP=900           # temps max en secondes (15 minutes)
PENALTY=30        # pénalité (s) appliquée à chaque fausse réponse à l'énigme
PENALTY_ACC=0     # accumulateur de pénalités

#---
START=$(date +%s)

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