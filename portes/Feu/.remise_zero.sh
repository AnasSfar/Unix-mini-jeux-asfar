if [[ -f .start_time ]]; then
    rm .start_time
fi

if [[ -f .final_time ]]; then
    rm .final_time
fi

if [[ -f .module_OK ]]; then
    rm .module_OK
fi

echo "♻️  La porte du Feu a été remise à zéro."
