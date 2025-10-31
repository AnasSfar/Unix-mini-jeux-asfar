# 🌌 Porta Elementa
> *Un voyage initiatique à travers les quatre éléments : Feu, Eau, Air et Terre.*  
> *Réunis leurs symboles et ouvre la Porte des Éléments.*

---

## 🧭 Concept général

**Porta Elementa** est un jeu textuel en **Bash**, à jouer directement dans le terminal **UNIX/Linux**.  

Clone le projet :
```bash
git clone https://github.com/AnasSfar/porta_elementa
```

Ensuite, accède au dossier du jeu :
```bash
cd porta_elementa/portes/elem
```

Le joueur parcourt quatre épreuves — **Feu**, **Eau**, **Air**, et **Terre**.  
Il est obligatoire de suivre cet ordre.  

Avant chaque épreuve, rends les scripts exécutables :
```bash
chmod +x elem.sh verif.sh
```

Puis lance :
```bash
./elem.sh     # pour commencer l’épreuve
./verif.sh    # pour vérifier ta réponse
```

Une description détaillée de l’épreuve s’affichera dès son lancement.  

Ta **maîtrise** dépend du **temps** et du **nombre d’erreurs**.  
Chaque élément te donne un **symbole secret**.  
Réunis-les pour tenter d’ouvrir la **Porte des Éléments** !

---

## ⏱️ Règles du jeu

Chaque épreuve dure **10 minutes maximum**.  
Si le temps s’écoule, **il suffit de recommencer l’épreuve concernée** (le reste de ta progression est conservé).  

Tu obtiens **1 à 3 étoiles** selon ta rapidité et ta précision.  
À la fin de chaque épreuve, tu reçois **un chiffre secret**.  

Quand tu as les quatre symboles :
- La **Porte Finale** t’invite à entrer le code ;  
- Si le code est incorrect → un indice t’est donné, et tu peux réessayer une fois ;  
- Si le code est juste → la porte s’ouvre et révèle ton **rang final** selon ton score total.

---

## 🔮 Philosophie du jeu

> Ici, on ne perd jamais.  
> On apprend, on observe, on se transforme.  
> Le véritable but n’est pas la victoire,  
> mais la compréhension de l’équilibre entre les éléments.  

Chaque erreur t’approche d’une réponse,  
chaque minute t’enseigne la patience.  

Les étoiles ⭐ ne mesurent pas seulement la victoire,  
elles mesurent aussi ta **maîtrise intérieure**.

- ⭐⭐⭐ — tu as répondu vite et juste : l’élément reconnaît ta maîtrise parfaite.  
- ⭐⭐ — tu as trouvé la vérité après quelques hésitations : l’équilibre reste fragile.  
- ⭐ — tu as mis du temps ou commis des erreurs : l’élément t’accorde tout de même son sceau.  
- 0 ⭐ — le temps s’est écoulé, il faudra recommencer avant d’avancer.

---

## 🗝️ Ouvrir la Porte des Éléments

Quand tu as terminé les quatre épreuves, retourne à la racine du jeu :

```bash
cd ~/porta_elementa
```

Assure-toi que le fichier `portail.sh` est exécutable :
```bash
chmod +x portail.sh
```

Puis ouvre le portail :
```bash
./portail.sh
```

Entre la combinaison secrète obtenue grâce aux quatre éléments 🔥💧🌬️🌍  
Si elle est correcte, le **Portail s’ouvrira** et révélera ton **titre final**.

---
