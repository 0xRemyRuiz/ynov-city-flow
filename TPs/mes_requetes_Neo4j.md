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
Entreprises → Noeud :Company
Parce que plusieurs utilisateurs travaillent dans la même entreprise. En faire un nœud permet de traverser le graphe : "tous les employés de cette entreprise", "collègues d'Alice", "anciens collègues". En propriété, aucune traversée possible.

Postes (jobs) → Propriétés sur la relation [:WORKED_AT]
Un poste n'a pas d'existence propre indépendante — il n'a de sens que dans le contexte du couple (utilisateur, entreprise). Les infos du poste (title, startYear, endYear) vont donc sur la relation elle-même, pas dans un nœud séparé.

Compétences → Nœud :Skill
Parce que les compétences sont partagées entre utilisateurs. En faire des nœuds permet de trouver "tous les utilisateurs ayant la compétence Python", ou "compétences en commun entre Alice et Bob"

jeu de donne
// Utilisateurs
CREATE (alice:User {name: 'Alice', email: 'alice@example.com', photo: 'alice.jpg'})
CREATE (bob:User {name: 'Bob', email: 'bob@example.com', photo: 'bob.jpg'})
CREATE (charlie:User {name: 'Charlie', email: 'charlie@example.com', photo: 'charlie.jpg'})
CREATE (diana:User {name: 'Diana', email: 'diana@example.com', photo: 'diana.jpg'})
CREATE (eve:User {name: 'Eve', email: 'eve@example.com', photo: 'eve.jpg'})
CREATE (frank:User {name: 'Frank', email: 'frank@example.com', photo: 'frank.jpg'})

// Entreprises
CREATE (google:Company {name: 'Google', sector: 'Tech', size: 'Grand'})
CREATE (meta:Company {name: 'Meta', sector: 'Tech', size: 'Grand'})
CREATE (startup:Company {name: 'StartupX', sector: 'FinTech', size: 'Petite'})
CREATE (ynov:Company {name: 'Ynov', sector: 'Education', size: 'Moyenne'})

// Compétences
CREATE (python:Skill {name: 'Python'})
CREATE (docker:Skill {name: 'Docker'})
CREATE (neo4j:Skill {name: 'Neo4j'})
CREATE (java:Skill {name: 'Java'})
CREATE (react:Skill {name: 'React'})

// Postes — WORKED_AT 
CREATE (alice)-[:WORKED_AT {title: 'Dev Backend', startYear: 2020, endYear: null}]->(google)
CREATE (alice)-[:WORKED_AT {title: 'Stagiaire', startYear: 2018, endYear: 2019}]->(meta)
CREATE (bob)-[:WORKED_AT {title: 'Dev Backend', startYear: 2021, endYear: null}]->(google)
CREATE (charlie)-[:WORKED_AT {title: 'Dev Frontend', startYear: 2020, endYear: null}]->(google)
CREATE (diana)-[:WORKED_AT {title: 'Data Engineer', startYear: 2019, endYear: 2022}]->(meta)
CREATE (diana)-[:WORKED_AT {title: 'Lead Data', startYear: 2022, endYear: null}]->(startup)
CREATE (eve)-[:WORKED_AT {title: 'Stagiaire', startYear: 2018, endYear: 2019}]->(meta)
CREATE (frank)-[:WORKED_AT {title: 'Formateur', startYear: 2021, endYear: null}]->(ynov)

// Compétences
CREATE (alice)-[:HAS_SKILL {level: 'expert'}]->(python)
CREATE (alice)-[:HAS_SKILL {level: 'intermédiaire'}]->(docker)
CREATE (alice)-[:HAS_SKILL {level: 'débutant'}]->(neo4j)
CREATE (bob)-[:HAS_SKILL {level: 'expert'}]->(python)
CREATE (bob)-[:HAS_SKILL {level: 'expert'}]->(docker)
CREATE (charlie)-[:HAS_SKILL {level: 'expert'}]->(react)
CREATE (charlie)-[:HAS_SKILL {level: 'intermédiaire'}]->(python)
CREATE (diana)-[:HAS_SKILL {level: 'expert'}]->(python)
CREATE (diana)-[:HAS_SKILL {level: 'intermédiaire'}]->(neo4j)
CREATE (eve)-[:HAS_SKILL {level: 'intermédiaire'}]->(docker)
CREATE (eve)-[:HAS_SKILL {level: 'débutant'}]->(python)
CREATE (frank)-[:HAS_SKILL {level: 'expert'}]->(neo4j)
CREATE (frank)-[:HAS_SKILL {level: 'intermédiaire'}]->(docker)

// Connexions réseau
CREATE (alice)-[:CONNECTED_TO {since: 2021}]->(bob)
CREATE (alice)-[:CONNECTED_TO {since: 2020}]->(charlie)
CREATE (bob)-[:CONNECTED_TO {since: 2021}]->(alice)
CREATE (diana)-[:CONNECTED_TO {since: 2020}]->(eve)

// Recommandations
CREATE (bob)-[:RECOMMENDS {message: 'Excellente dev, très rigoureuse', date: date('2023-06-01')}]->(alice)
CREATE (charlie)-[:RECOMMENDS {message: 'Super coéquipière', date: date('2023-09-15')}]->(alice)
3. Écrivez en Cypher la requête « trouver les collègues actuels d'Alice ».
MATCH (alice:User {name: 'Alice'})-[r1:WORKED_AT]->(company:Company)<-[r2:WORKED_AT]-(colleague:User)
WHERE r1.endYear IS NULL
  AND r2.endYear IS NULL
  AND colleague <> alice
RETURN colleague.name AS collegue,
       company.name AS entreprise,
       r2.title AS poste
4. Écrivez la requête « trouver les ex-collègues d'Alice qu'elle n'a pas dans son réseau ».
MATCH (alice:User {name: 'Alice'})-[:WORKED_AT]->(company:Company)<-[:WORKED_AT]-(exColleague:User)
WHERE exColleague <> alice
  AND NOT (alice)-[:CONNECTED_TO]->(exColleague)
  AND NOT (exColleague)-[:CONNECTED_TO]->(alice)
RETURN DISTINCT exColleague.name AS exCollegue,
                company.name AS entrepriseEnCommun
5. Écrivez la requête « recommander 3 personnes basées sur des compétences communes ».
MATCH (alice:User {name: 'Alice'})-[:HAS_SKILL]->(skill:Skill)<-[:HAS_SKILL]-(other:User)
WHERE other <> alice
  AND NOT (alice)-[:CONNECTED_TO]->(other)
WITH other, collect(skill.name) AS commonSkills, count(skill) AS nbSkills
RETURN other.name AS recommandation,
       commonSkills AS competencesEnCommun,
       nbSkills AS nbCompetencesCommunes
ORDER BY nbSkills DESC
LIMIT 3

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
Noeuds :Genre
En noeud, un genre devient un point de pivot réutilisable entre films, utilisateurs et recommandations

jeux de donne
// Utilisateurs
CREATE (alice:User {name: 'Alice', subscription: 'Premium'})
CREATE (bob:User {name: 'Bob', subscription: 'Standard'})
CREATE (charlie:User {name: 'Charlie', subscription: 'Premium'})
CREATE (diana:User {name: 'Diana', subscription: 'Basic'})
CREATE (eve:User {name: 'Eve', subscription: 'Premium'})

// Genres
CREATE (thriller:Genre {name: 'Thriller'})
CREATE (drama:Genre {name: 'Drama'})
CREATE (action:Genre {name: 'Action'})
CREATE (scifi:Genre {name: 'Sci-Fi'})
CREATE (comedy:Genre {name: 'Comedy'})

// Films
CREATE (m1:Movie {title: 'Edge of Tomorrow', year: 2014, duration: 113})
CREATE (m2:Movie {title: 'Gone Girl', year: 2014, duration: 149})
CREATE (m3:Movie {title: 'Prisoners', year: 2013, duration: 153})
CREATE (m4:Movie {title: 'Inception', year: 2010, duration: 148})
CREATE (m5:Movie {title: 'The Prestige', year: 2006, duration: 130})
CREATE (m6:Movie {title: 'Zodiac', year: 2007, duration: 157})
CREATE (m7:Movie {title: 'Knives Out', year: 2019, duration: 130})
CREATE (m8:Movie {title: 'Tenet', year: 2020, duration: 150})

// Acteurs
CREATE (a1:Actor {name: 'Tom Cruise', birthYear: 1962})
CREATE (a2:Actor {name: 'Emily Blunt', birthYear: 1983})
CREATE (a3:Actor {name: 'Ben Affleck', birthYear: 1972})
CREATE (a4:Actor {name: 'Hugh Jackman', birthYear: 1968})
CREATE (a5:Actor {name: 'Christian Bale', birthYear: 1974})
CREATE (a6:Actor {name: 'Jake Gyllenhaal', birthYear: 1980})
CREATE (a7:Actor {name: 'Leonardo DiCaprio', birthYear: 1974})

// Réalisateurs
CREATE (d1:Director {name: 'Doug Liman', birthYear: 1965})
CREATE (d2:Director {name: 'David Fincher', birthYear: 1962})
CREATE (d3:Director {name: 'Denis Villeneuve', birthYear: 1967})
CREATE (d4:Director {name: 'Christopher Nolan', birthYear: 1970})
CREATE (d5:Director {name: 'Rian Johnson', birthYear: 1973})

// Genres des films
CREATE (m1)-[:HAS_GENRE]->(thriller)
CREATE (m1)-[:HAS_GENRE]->(scifi)
CREATE (m1)-[:HAS_GENRE]->(action)
CREATE (m2)-[:HAS_GENRE]->(thriller)
CREATE (m2)-[:HAS_GENRE]->(drama)
CREATE (m3)-[:HAS_GENRE]->(thriller)
CREATE (m3)-[:HAS_GENRE]->(drama)
CREATE (m4)-[:HAS_GENRE]->(scifi)
CREATE (m4)-[:HAS_GENRE]->(action)
CREATE (m5)-[:HAS_GENRE]->(thriller)
CREATE (m5)-[:HAS_GENRE]->(drama)
CREATE (m6)-[:HAS_GENRE]->(thriller)
CREATE (m6)-[:HAS_GENRE]->(drama)
CREATE (m7)-[:HAS_GENRE]->(comedy)
CREATE (m7)-[:HAS_GENRE]->(thriller)
CREATE (m8)-[:HAS_GENRE]->(scifi)
CREATE (m8)-[:HAS_GENRE]->(action)

// Casting
CREATE (a1)-[:ACTED_IN {role: 'Cage'}]->(m1)
CREATE (a2)-[:ACTED_IN {role: 'Rita'}]->(m1)
CREATE (a3)-[:ACTED_IN {role: 'Nick'}]->(m2)
CREATE (a6)-[:ACTED_IN {role: 'Keller'}]->(m3)
CREATE (a5)-[:ACTED_IN {role: 'Franklin'}]->(m3)
CREATE (a7)-[:ACTED_IN {role: 'Cobb'}]->(m4)
CREATE (a5)-[:ACTED_IN {role: 'Borden'}]->(m5)
CREATE (a4)-[:ACTED_IN {role: 'Angier'}]->(m5)
CREATE (a6)-[:ACTED_IN {role: 'Graysmith'}]->(m6)
CREATE (a4)-[:ACTED_IN {role: 'Protagonist'}]->(m8)
CREATE (a1)-[:ACTED_IN {role: 'Ethan'}]->(m6)
CREATE (a2)-[:ACTED_IN {role: 'Agent'}]->(m4)

// Réalisateurs
CREATE (d1)-[:DIRECTED]->(m1)
CREATE (d2)-[:DIRECTED]->(m2)
CREATE (d3)-[:DIRECTED]->(m3)
CREATE (d4)-[:DIRECTED]->(m4)
CREATE (d4)-[:DIRECTED]->(m5)
CREATE (d2)-[:DIRECTED]->(m6)
CREATE (d5)-[:DIRECTED]->(m7)
CREATE (d4)-[:DIRECTED]->(m8)

// Notes
CREATE (alice)-[:RATED {rating: 5, date: date('2024-01-10')}]->(m1)
CREATE (alice)-[:RATED {rating: 4, date: date('2024-02-15')}]->(m2)
CREATE (alice)-[:RATED {rating: 5, date: date('2024-03-01')}]->(m3)
CREATE (alice)-[:RATED {rating: 3, date: date('2024-03-20')}]->(m4)
CREATE (alice)-[:RATED {rating: 4, date: date('2024-04-05')}]->(m5)

CREATE (bob)-[:RATED {rating: 5, date: date('2024-01-12')}]->(m1)
CREATE (bob)-[:RATED {rating: 4, date: date('2024-02-18')}]->(m3)
CREATE (bob)-[:RATED {rating: 5, date: date('2024-03-02')}]->(m5)
CREATE (bob)-[:RATED {rating: 5, date: date('2024-04-10')}]->(m6)
CREATE (bob)-[:RATED {rating: 4, date: date('2024-05-01')}]->(m8)

CREATE (charlie)-[:RATED {rating: 5, date: date('2024-01-20')}]->(m1)
CREATE (charlie)-[:RATED {rating: 5, date: date('2024-02-25')}]->(m5)
CREATE (charlie)-[:RATED {rating: 4, date: date('2024-03-15')}]->(m6)
CREATE (charlie)-[:RATED {rating: 5, date: date('2024-04-20')}]->(m7)

CREATE (diana)-[:RATED {rating: 2, date: date('2024-01-05')}]->(m4)
CREATE (diana)-[:RATED {rating: 3, date: date('2024-02-10')}]->(m7)

CREATE (eve)-[:RATED {rating: 4, date: date('2024-01-08')}]->(m3)
CREATE (eve)-[:RATED {rating: 5, date: date('2024-02-12')}]->(m5)
CREATE (eve)-[:RATED {rating: 5, date: date('2024-03-18')}]->(m6)
CREATE (eve)-[:RATED {rating: 3, date: date('2024-04-22')}]->(m8)

// Watchlist
CREATE (alice)-[:WANTS_TO_WATCH {addedDate: date('2024-05-01')}]->(m6)
CREATE (alice)-[:WANTS_TO_WATCH {addedDate: date('2024-05-02')}]->(m7)
CREATE (bob)-[:WANTS_TO_WATCH {addedDate: date('2024-05-03')}]->(m2)
CREATE (diana)-[:WANTS_TO_WATCH {addedDate: date('2024-05-04')}]->(m1)

3. Écrivez en Cypher : « films notés 4+ par Alice dans le genre thriller ».
MATCH (alice:User {name: 'Alice'})-[r:RATED]->(m:Movie)-[:HAS_GENRE]->(g:Genre {name: 'Thriller'})
WHERE r.rating >= 4
RETURN m.title AS film,
       r.rating AS note,
       r.date AS dateVu
ORDER BY r.rating DESC

4. Écrivez : « recommander à Alice des films vus et bien notés par les utilisateurs qui aiment les
mêmes films qu'elle ». (la fameuse recommandation collaborative !)
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

