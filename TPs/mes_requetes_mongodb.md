
PARTIE 8
========
Niveau 1 — Filtres simples
--------------------------
1. Trouvez tous les utilisateurs entre 25 et 35 ans (inclus aux deux bornes).
2. Trouvez les utilisateurs dont l'email contient example.com (indice : opérateur $regex).
3. Trouvez les utilisateurs qui ont exactement 2 adresses.
4. Trouvez les utilisateurs qui n'ont pas le champ preferences.

Niveau 2 — Combinaisons
-----------------------
5. Trouvez les utilisateurs habitant Lyon OU Villeurbanne, et de plus de 25 ans.
6. Trouvez les utilisateurs qui ont au moins une adresse de type home à Lyon.
7. Trouvez les utilisateurs qui ont les tags premium ET eco-friendly ensemble.

Niveau 3 — Tri et pagination
----------------------------
8. Affichez les 3 utilisateurs les plus âgés, en ne renvoyant que firstName, age et email.
9. Affichez les utilisateurs triés par ville (alphabétique), puis par âge décroissant.
10. Implémentez une pagination : page 2 avec 2 utilisateurs par page, triés par createdAt.

Niveau 4 — Bonus pour les rapides
---------------------------------
11. Trouvez les utilisateurs vérifiés âgés de moins de 30 ans, n'habitant pas Lyon.
12. Trouvez les utilisateurs dont au moins un tag commence par la lettre 'p' (indice : $regex dans
un tableau).

PARTIE 9
========
Niveau 1 — Agrégations simples
------------------------------
1. Comptez le nombre total d'utilisateurs dans votre collection.
2. Calculez l'âge moyen, le plus jeune et le plus âgé de votre base.
3. Comptez combien d'utilisateurs sont vérifiés (et combien ne le sont pas).

Niveau 2 — Regroupements
------------------------
4. Comptez le nombre d'utilisateurs par ville (utilisez $unwind sur addresses).
5. Trouvez l'âge moyen par ville, trié par âge moyen décroissant.
6. Identifiez les 3 tags les plus utilisés et le nombre d'utilisateurs pour chacun.

Niveau 3 — Pipelines complexes
------------------------------
7. Pour chaque ville, listez les firstName de tous les utilisateurs qui y habitent (utilisez $push ou
$addToSet).
8. Calculez la proportion d'utilisateurs vérifiés par ville (champ calculé : verifiedCount /
totalCount).
9. Trouvez les utilisateurs qui ont le plus grand nombre d'adresses ($project pour ajouter un champ
addressCount).

Stratégie d'indexation
======================
1. Listez les champs les plus utilisés en filtre dans vos requêtes.
2. Listez les champs les plus utilisés en tri.
3. Proposez au moins 3 index pertinents (un simple, un composé, un éventuellement unique).
4. Créez-les dans mongo-express via l'onglet Indexes.
5. Pour chaque index créé, justifiez son existence dans votre fichier mes_requetes.md.
Question bonus : quel serait l'index idéal pour la requête « utilisateurs habitant Lyon, âgés de 18
à 30 ans, triés par createdAt décroissant » ? Appliquez la règle ESR.