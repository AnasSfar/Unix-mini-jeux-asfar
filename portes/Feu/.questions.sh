#!/bin/bash
source ../../utils/timer.sh
source ../../utils/scoring.sh

start_timer

# On choisit 5 questions au hasard parmi 20
mapfile -t QUESTIONS < <(shuf -n 5 questions_feu.txt)

errors=0

for ligne in "${QUESTIONS[@]}"; do
    question=$(echo "$ligne" | cut -d';' -f1)
    bonne_reponse=$(echo "$ligne" | cut -d';' -f2)

    echo ""
    echo "🔥 $question (Vrai / Faux)"
    read -r reponse

    # Si le joueur veut quitter
    if [[ "${reponse,,}" == "out" ]]; then
        echo "💨 Tu abandonnes la flamme..."
        exit 0
    fi

    bash .rep.sh "$reponse" "$bonne_reponse"
    if [[ $? -ne 0 ]]; then
        ((errors++))
    fi
done

verifier_temps_ecoule
calculer_etoiles "$errors"
3️⃣ .rep.sh
🧠 → Vérifie la réponse du joueur.

bash
Copier le code
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
