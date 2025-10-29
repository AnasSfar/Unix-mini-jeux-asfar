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

# Création du labyrinthe
LAB="lab_feu"
rm -rf "$LAB"
mkdir -p "$LAB"/{combustible/{bois,papier},comburant/{air,oxygene},energie/{etincelle,friction}}

# 2) Choix du fichier et de l'énigme
dossiers=($(find "$lab" -type d))
fichier_cache="${dossiers[$RANDOM % ${#dossiers[@]}]}/flamme.txt"

enigmes=(
  "Énigme FEU : Je nais de l'étreinte de l'air et du bois. Qui suis-je ?"
  "Énigme FEU : Plus je suis chaude, plus je deviens bleue. Quelle est ma couleur ?"
  "Énigme FEU : Je reste quand tout brûle. Qui suis-je ?"
)
reponses=("feu" "bleu" "cendre")

choix=$((RANDOM % ${#enigmes[@]}]))
echo "${enigmes[$choix]}" > "$fichier_cache"
bonne="${reponses[$choix]}"
nom_fichier="$(basename "$fichier_cache")"

echo "🎯 Le fichier mystère s'appelle : $nom_fichier"
echo
echo "💡 Explore le labyrinthe 'lab_feu/' pour le trouver !"
echo "   Astuce :"
echo "     find . -type f -name \"$nom_fichier\""
echo "     grep -R \"Énigme FEU\" ."
echo

# Le joueur cherche dans le terminal par lui-même.
# Le script continue de surveiller le temps.

# --- 3) Pose la question (une fois qu’il a lu l’énigme) ---
while true; do
  maintenant=$(date +%s)
  temps_utilise=$(( (maintenant - debut) + total_penalites ))
  temps_restant=$(( limite - temps_utilise ))
  if (( temps_restant <= 0 )); then
    echo "⏰ Le temps est écoulé !"
    echo "⭐ Étoiles : 0"
    echo "💀 La flamme s’est éteinte... Ton épreuve est un tas de cendres."
    exit 0
  fi

  echo -n "🔥 Ta réponse à l'énigme ($temps_restant s restants) > "
  if ! read -r -t "$temps_restant" rep; then
    echo "⏰ Le temps est écoulé !"
    echo "⭐ Étoiles : 0"
    echo "💀 La flamme s’est éteinte... Ton épreuve est un tas de cendres."
    exit 0
  fi
  [[ "${rep,,}" == "out" ]] && { echo "💨 Tu as fui les flammes."; exit 0; }

  # Vérification via script séparé
  if bash "$(dirname "$0")/verif_rep" "$rep" "$bonne"; then
    echo "✔️ Bonne réponse !"
    break
  else
    total_penalites=$(( total_penalites + penalite ))
    echo "❌ Mauvaise réponse. +${penalite}s de pénalité (total = ${total_penalites}s)."
  fi
done

# --- 4) Calcul du score et message final ---
fin=$(date +%s)
temps_brut=$(( fin - debut ))
temps_total=$(( temps_brut + total_penalites ))
(( temps_total > limite )) && temps_total=$limite

etoiles=1
(( temps_total <= 300 )) && etoiles=3
(( temps_total > 300 && temps_total <= 600 )) && etoiles=2

m=$((temps_brut/60)); s=$((temps_brut%60))

if (( etoiles == 3 )); then
  message="🔥 Bravo, maître des flammes ! Le Feu t’obéit et danse à ton commandement."
elif (( etoiles == 2 )); then
  message="🔥 Bon effort, voyageur ardent. Le Feu t’a reconnu, mais tes cendres fument encore..."
elif (( etoiles == 1 )); then
  message="🔥 L’épreuve t’a consumé lentement... Tes flammes vacillent, mais subsistent encore."
else
  message="💀 La flamme s’est éteinte. Il ne reste que des braises froides et ton échec."
fi

echo
echo "🔥Fin de l'épreuve, voyons si tu as réussi à trouver ton équilibre"
printf "⏱ Temps brut     : %dm %02ds\n" "$m" "$s"
echo   "⛔ Erreurs      : ${total_penalites}s"
echo   "🧮 Temps total    : ${temps_total}s / ${limite}s"
echo   "⭐ Étoiles        : ${etoiles}"
echo "$message"