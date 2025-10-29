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
dossiers_feu=($(find "$LAB" -type d))
chemin_fichier="${dossiers_feu[$RANDOM % ${#dossiers_feu[@]}]}/flamme.txt"

enigmes=(
  "Énigme FEU : Je nais de l'étreinte de l'air et du bois. Qui suis-je ?"
  "Énigme FEU : Plus je suis chaude, plus je deviens bleue. Quelle est ma couleur ?"
  "Énigme FEU : Je reste quand tout brûle. Qui suis-je ?"
)
reponses=("feu" "bleu" "cendre")

choix=$((RANDOM % ${#enigmes[@]}))
echo "${enigmes[$choix]}" > "$chemin_fichier"
bonne_reponse="${reponses[$choix]}"
nom_fichier="$(basename "$chemin_fichier")"

echo "🔥 Cherche le fichier nommé : $nom_fichier"
echo ""

# 3) Demande chemin du fichier
while true; do
  maintenant=$(date +%s)
  temps_utilise=$(( (maintenant - debut) + total_penalites ))
  temps_restant=$(( limite - temps_utilise ))

  # condition de temps
  if (( temps_restant <= 0 )); then
    echo "⏰ Le temps est écoulé !"
    echo "⭐ Étoiles : 0"
    exit 0
  fi

  echo -n "Chemin ABSOLU du fichier ($temps_restant s restants) > "
  if ! read -r -t "$temps_restant" chemin; then
    echo "⏰ Le temps est écoulé !"
    echo "⭐ Étoiles : 0"
    exit 0
  fi

  [[ "${chemin,,}" == "out" ]] && { echo "💨 Abandon."; exit 0; }

  if [[ -f "$chemin" && "$(basename "$chemin")" == "$nom_fichier" && "$(realpath "$chemin")" == "$(realpath "$fichier_cache")" ]]; then
    echo "✔️  Fichier trouvé !"
    echo "------ ÉNIGME ------"; cat "$chemin"; echo "--------------------"
    break
  else
    echo "❌ Mauvais fichier. Essaie encore."
  fi
done

# 4) Vérif rép question
while true; do
  maintenant=$(date +%s)
  temps_utilise=$(( (maintenant - debut) + total_penalites ))
  temps_restant=$(( limite - temps_utilise ))

  if (( temps_restant <= 0 )); then
    echo "⏰ Le temps est écoulé !"
    echo "⭐ Étoiles : 0"
    exit 0
  fi

  echo -n "Réponse à l'énigme ($temps_restant s restants) > "
  if ! read -r -t "$temps_restant" reponse; then
    echo "⏰ Le temps est écoulé !"
    echo "⭐ Étoiles : 0"
    exit 0
  fi

  [[ "${reponse,,}" == "out" ]] && { echo "💨 Abandon."; exit 0; }

  reponse_norm="$(echo "$reponse" | tr '[:upper:]' '[:lower:]' | xargs)"
  bonne_norm="$(echo "$bonne" | tr '[:upper:]' '[:lower:]' | xargs)"

  if [[ "$reponse_norm" == "$bonne_norm" ]]; then
    echo "✔️ Bonne réponse !"
    break
  else
    total_penalites=$(( total_penalites + penalite ))
    echo "❌ Mauvaise réponse. +${penalite}s de pénalité (total = ${total_penalites}s)."
  fi
done

# 5) score et fin du jeu
fin=$(date +%s)
temps_brut=$(( fin - debut ))
temps_total=$(( temps_brut + total_penalites ))
(( temps_total > limite )) && temps_total=$limite

etoiles=1
(( temps_total <= 300 )) && etoiles=3
(( temps_total > 300 && temps_total <= 600 )) && etoiles=2

m=$((temps_brut/60)); s=$((temps_brut%60))

echo
echo "🔥Fin de l'épreuve, voyons voir si vous avez trouver votre équilibre"
printf "⏱ Temps brut       : %dm %02ds\n" $((brut/60)) $((brut%60))
echo   "⛔ Pénalités        : ${penalites}s"
echo   "⭐ Étoiles          : ${etoiles}"

# --- 6) Message final thématique selon le résultat ---
if (( etoiles == 3 )); then
  message="🔥 Bravo, maître des flammes ! Le Feu t’obéit et danse à ton commandement."
elif (( etoiles == 2 )); then
  message="🔥 Bon effort, voyageur ardent. Le Feu t’a reconnu, mais tes cendres fument encore..."
elif (( etoiles == 1 )); then
  message="🔥 L’épreuve t’a consumé lentement... Tes flammes vacillent, mais subsistent encore."
else
  message="💀 La flamme s’est éteinte. Il ne reste que des braises froides et ton échec."
fi

echo "$message"
