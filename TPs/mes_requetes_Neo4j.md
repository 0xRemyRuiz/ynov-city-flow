Exercice 1
----------
Voir les requêtes dans `seed/neo4j/init.cypher`
1. Pour chaque concept (entreprises, postes, compétences) : nœud ou propriété ? Justifiez.
 1. Pour les entreprises
  - Réponse : `Entreprises → Noeud :Company`
  - Justification : Parce que plusieurs utilisateurs travaillent dans la même entreprise. En faire un nœud permet de traverser le graphe : "tous les employés de cette entreprise", "collègues d'Alice", "anciens collègues". En propriété, aucune traversée possible.
 2. Pour les postes
  - Réponse : `Postes (jobs) → Propriétés sur la relation [:WORKED_AT]`
  - Justification : Un poste n'a pas d'existence propre indépendante — il n'a de sens que dans le contexte du couple (utilisateur, entreprise). Les infos du poste (title, startYear, endYear) vont donc sur la relation elle-même, pas dans un nœud séparé.
 3. Pour les compétences
  - Réponse : `Compétences → Nœud :Skill`
  - Justification : Parce que les compétences sont partagées entre utilisateurs. En faire des nœuds permet de trouver "tous les utilisateurs ayant la compétence Python", ou "compétences en commun entre Alice et Bob"

3. Écrivez en Cypher la requête « trouver les collègues actuels d'Alice ».
 - Requête :
```cypher
MATCH (alice:User {name: 'Alice'})-[r1:WORKED_AT]->(company:Company)<-[r2:WORKED_AT]-(colleague:User)
WHERE r1.endYear IS NULL
  AND r2.endYear IS NULL
  AND colleague <> alice
RETURN colleague.name AS collegue,
       company.name AS entreprise,
       r2.title AS poste
```
 - Réponse : ``

4. Écrivez la requête « trouver les ex-collègues d'Alice qu'elle n'a pas dans son réseau ».
 - Requête :
```cypher
MATCH (alice:User {name: 'Alice'})-[:WORKED_AT]->(company:Company)<-[:WORKED_AT]-(exColleague:User)
WHERE exColleague <> alice
  AND NOT (alice)-[:CONNECTED_TO]->(exColleague)
  AND NOT (exColleague)-[:CONNECTED_TO]->(alice)
RETURN DISTINCT exColleague.name AS exCollegue,
                company.name AS entrepriseEnCommun
```
 - Réponse : ``

5. Écrivez la requête « recommander 3 personnes basées sur des compétences communes ».
 - Requête :
```cypher
MATCH (alice:User {name: 'Alice'})-[:HAS_SKILL]->(skill:Skill)<-[:HAS_SKILL]-(other:User)
WHERE other <> alice
  AND NOT (alice)-[:CONNECTED_TO]->(other)
WITH other, collect(skill.name) AS commonSkills, count(skill) AS nbSkills
RETURN other.name AS recommandation,
       commonSkills AS competencesEnCommun,
       nbSkills AS nbCompetencesCommunes
ORDER BY nbSkills DESC
LIMIT 3
```
 - Réponse : ``

Exercice 2
----------
1. Modélisez le graphe (nœuds, relations, propriétés).
 - Requêtes cf. `seed/neo4j/init.cypher`
2. Genres : nœuds ou propriétés ? Justifiez selon le besoin de filtrage.
Noeuds :Genre
En noeud, un genre devient un point de pivot réutilisable entre films, utilisateurs et recommandations

3. Écrivez en Cypher : « films notés 4+ par Alice dans le genre thriller ».
 - Requête :
```cypher
MATCH (alice:User {name: 'Alice'})-[r:RATED]->(m:Movie)-[:HAS_GENRE]->(g:Genre {name: 'Thriller'})
WHERE r.rating >= 4
RETURN m.title AS film,
       r.rating AS note,
       r.date AS dateVu
ORDER BY r.rating DESC
```
 - Réponse : ``

4. Écrivez : « recommander à Alice des films vus et bien notés par les utilisateurs qui aiment les
mêmes films qu'elle ». (la fameuse recommandation collaborative !)
 - Requête :
```cypher
MATCH (alice:User {name: 'Alice'})-[r1:RATED]->(common:Movie)<-[r2:RATED]-(other:User)
WHERE r1.rating >= 4
  AND r2.rating >= 4
  AND other <> alice

MATCH (other)-[r3:RATED]->(reco:Movie)
WHERE r3.rating >= 4
  AND NOT EXISTS {
    MATCH (alice)-[:RATED]->(reco)
  }
  AND NOT EXISTS {
    MATCH (alice)-[:WANTS_TO_WATCH]->(reco)
  }

RETURN reco.title AS filmRecommande,
       count(DISTINCT other) AS nbUtilisateursSimilaires,
       round(avg(r3.rating), 2) AS noteMoyenne,
       collect(DISTINCT other.name) AS recommandePar
ORDER BY nbUtilisateursSimilaires DESC, noteMoyenne DESC
LIMIT 5
```
 - Réponse : ``

5. Écrivez : « les acteurs qui ont joué dans plus de 3 films avec une note moyenne > 4 ».

Exercice 3
----------
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
Faites en sorte que chaque utilisateur ait noté au moins 2 films, avec des ratings variés (de 1 à 5).
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

