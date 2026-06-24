MATCH (n) DETACH DELETE n;

/*
 * Linkedin-like TP
 */
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

/*
 * Netflix-like TP
 */
// Utilisateurs (MATCH to integrate with previous users)
MATCH (u:User {name: 'Alice'}) SET u.subscription = 'Premium'
MATCH (u:User {name: 'Bob'}) SET u.subscription = 'Standard'
MATCH (u:User {name: 'Charlie'}) SET u.subscription = 'Premium'
MATCH (u:User {name: 'Diana'}) SET u.subscription = 'Basic'
MATCH (u:User {name: 'Eve'}) SET u.subscription = 'Premium'
// Franck has no subscription to the netflix app
MATCH (u:User {name: 'Franck'}) SET u.subscription = 'None'

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

/*
 * cityflow
 */
