 Exercice 1 
 Vous modélisez une plateforme professionnelle type LinkedIn avec :
- Utilisateurs (nom, email, photo)
- Entreprises (nom, secteur, taille)
- Postes occupés (jobs) avec titre, période, entreprise
- Compétences (skills) avec nom
- Relations entre utilisateurs (connexions, mais aussi recommandations professionnelles)
Travail demandé sur papier :
1. Dessinez le graphe : nœuds (avec leurs labels), relations typées (avec leur sens), propriétés sur
les uns et les autres.
2. Pour chaque concept (entreprises, postes, compétences) : nœud ou propriété ? Justifiez.
3. Écrivez en Cypher la requête « trouver les collègues actuels d'Alice ».
© KAKE Abdoulaye — Code & Passion — TP Neo4j pas à pas — Ynov Campus Lyon — 2025/2026
4. Écrivez la requête « trouver les ex-collègues d'Alice qu'elle n'a pas dans son réseau ».
5. Écrivez la requête « recommander 3 personnes basées sur des compétences communes ».

 Exercice 2
 Vous modélisez Netflix :
- Utilisateurs avec profil (nom, abonnement)
- Films et séries (titre, année, genres, durée)
- Acteurs et réalisateurs
- Utilisateurs notent les films (rating de 1 à 5)
- Utilisateurs ont une watchlist (films à voir)
Travail demandé :
1. Modélisez le graphe (nœuds, relations, propriétés).
2. Genres : nœuds ou propriétés ? Justifiez selon le besoin de filtrage.
3. Écrivez en Cypher : « films notés 4+ par Alice dans le genre thriller ».
4. Écrivez : « recommander à Alice des films vus et bien notés par les utilisateurs qui aiment les
mêmes films qu'elle ». (la fameuse recommandation collaborative !)
5. Écrivez : « les acteurs qui ont joué dans plus de 3 films avec une note moyenne > 4 ».

Exercice 3
Vous modélisez un réseau de transport en commun de la métropole de Lyon :
- Stations (nom, code, type : métro, tram, bus, vélo)
- Lignes (numéro, couleur, type)
- Connexions entre stations avec une durée et une distance
- Utilisateurs qui empruntent des trajets (départ, arrivée, date, durée)
Travail demandé :
1. Modélisez le graphe. Réfléchissez : la relation CONNECTED_TO entre deux stations doit-elle
être bi-directionnelle ?
2. Comment représenter qu'une ligne passe par une station ? Relation ou nœud intermédiaire ?
3. Écrivez la requête « toutes les stations directement connectées à Bellecour ».
4. Écrivez la requête « le plus court chemin (en nombre de stations) entre Bellecour et
Croix-Rousse ». (indice : shortestPath, on en parle dans la partie 8)
5. Réfléchissez : comment ajouteriez-vous la durée de trajet à votre modèle pour calculer le trajet
le plus rapide plutôt que celui avec le moins de stations ?

VOTRE TOUR — Enrichir votre graphe
Étape 1 — Ajouter 4 utilisateurs supplémentaires
Créez 4 utilisateurs supplémentaires (à votre choix de noms, âges, villes). Utilisez CREATE ou
MERGE. Au total vous devez avoir 10 utilisateurs.
Étape 2 — Ajouter des amitiés
Créez au moins 10 nouvelles amitiés entre les utilisateurs, en variant les dates (since). Pensez à
respecter la cohérence : si Alice est amie avec Bob, Bob est amie avec Alice (relation symétrique).
Étape 3 — Ajouter 3 films + des likes
Créez 3 nouveaux films avec leurs propriétés (titre, année, genre).
Faites en sorte que chaque utilisateur ait noté au moins 2 films, avec des ratings variés (de 1 à
5).
Étape 4 — Ajouter un type de nœud `Genre`
Créez les nœuds :Genre et reliez chaque film à son genre via :IN_GENRE. Pourquoi faire ça plutôt
que garder le genre comme propriété ? Réfléchissez et notez votre raisonnement dans
mes_requetes_cypher.md.
Étape 5 — Validation visuelle
Lancez MATCH (n) RETURN n LIMIT 200 et observez votre graphe complet. Vous devez voir un
réseau visiblement dense, avec plusieurs zones interconnectées.

VOTRE TOUR — Requêtes Cypher à produire
Pour chaque demande, écrivez votre propre requête Cypher, testez, et notez dans
mes_requetes_cypher.md.
Niveau 1 — MATCH simples
1. Listez tous les utilisateurs de plus de 25 ans, triés par âge décroissant.
2. Listez les utilisateurs habitant Lyon OU Villeurbanne.
3. Comptez le nombre total d'utilisateurs et le nombre total de films.
4. Listez tous les films de SF, triés par année croissante.
Niveau 2 — Relations simples
5. Listez les amis directs de Carol (avec leur nom et leur ville).
6. Combien d'amis a chaque utilisateur ? Affichez la liste triée par nombre décroissant.
7. Listez les films que Bob a notés, avec leurs notes.
8. Quelle est la note moyenne du film 'Inception' ?
Niveau 3 — Traversées à 2 niveaux
9. Listez les amis d'amis d'Alice (à profondeur exactement 2).
10. Listez les films aimés par les amis directs d'Alice, qu'Alice elle-même n'a pas notés.
11. Pour chaque utilisateur, listez les genres de films qu'il aime (via :IN_GENRE).
Niveau 4 — Agrégations
12. Top 3 des films les plus populaires (par nombre de likes).
13. Note moyenne par film, triée décroissante.
14. Pour chaque ville, comptez le nombre d'utilisateurs.
15. Utilisateurs ayant noté au moins 3 films.
Niveau 5 — Recommandations
16. Recommandation par amis communs : pour Alice, trouvez les utilisateurs avec qui elle a au
moins 2 amis communs mais à qui elle n'est pas connectée directement.
17. Recommandation collaborative simple : pour Alice, trouvez les films qu'elle n'a pas notés
mais qui ont été notés ≥ 4 par au moins 2 de ses amis.
18. Items populaires entre amis : trouvez les films aimés par plus de 3 utilisateurs différents et
leur note moyenne.
Niveau 6 — Bonus
19. Quel est l'utilisateur le plus connecté du réseau (= celui avec le plus d'amis) ?
20. Existe-t-il une « clique » de 3 utilisateurs tous amis entre eux ? (indice : MATCH
(a)-[:FRIEND_OF]-(b)-[:FRIEND_OF]-(c)-[:FRIEND_OF]-(a))

