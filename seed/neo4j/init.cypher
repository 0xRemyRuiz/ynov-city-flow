// 1. Base Structural Constraints & Indexes
CREATE INDEX user_name_idx IF NOT EXISTS FOR (u:User) ON (u.name);
CREATE INDEX movie_title_idx IF NOT EXISTS FOR (m:Movie) ON (m.title);

// 2. Clear existing data to ensure idempotency on reboot
MATCH (n) DETACH DELETE n;

// 3. Seed Users
CREATE (:User {id: "u001", name: "Alice", subscriptionType: "Premium"});
CREATE (:User {id: "u002", name: "Bob", subscriptionType: "Standard"});
CREATE (:User {id: "u003", name: "Charlie", subscriptionType: "Basic"});
CREATE (:User {id: "u004", name: "David", subscriptionType: "Premium"});

// 4. Seed Genres
CREATE (:Genre {name: "Thriller"});
CREATE (:Genre {name: "Action"});
CREATE (:Genre {name: "Sci-Fi"});

// 5. Seed Movies & People
CREATE (m1:Movie {id: "m1", title: "Inception", year: 2010, durationMin: 148});
CREATE (m2:Movie {id: "m2", title: "Shutter Island", year: 2010, durationMin: 138});
CREATE (m3:Movie {id: "m3", title: "The Dark Knight", year: 2008, durationMin: 152});
CREATE (p1:Person {id: "p1", name: "Leonardo DiCaprio"});
CREATE (p2:Person {id: "p2", name: "Christopher Nolan"});

// 6. Connect Nodes (Genres, Cast, Crew)
MATCH (m:Movie {id: "m1"}), (g:Genre {name: "Sci-Fi"}) CREATE (m)-[:BELONGS_TO]->(g);
MATCH (m:Movie {id: "m2"}), (g:Genre {name: "Thriller"}) CREATE (m)-[:BELONGS_TO]->(g);
MATCH (m:Movie {id: "m3"}), (g:Genre {name: "Action"}) CREATE (m)-[:BELONGS_TO]->(g);
MATCH (p:Person {id: "p1"}), (m:Movie {id: "m1"}) CREATE (p)-[:ACTED_IN]->(m);
MATCH (p:Person {id: "p1"}), (m:Movie {id: "m2"}) CREATE (p)-[:ACTED_IN]->(m);
MATCH (p:Person {id: "p2"}), (m:Movie {id: "m1"}) CREATE (p)-[:DIRECTED]->(m);
MATCH (p:Person {id: "p2"}), (m:Movie {id: "m3"}) CREATE (p)-[:DIRECTED]->(m);

// 7. Seed User Interactions (Ratings and Watchlists)
MATCH (u:User {name: "Alice"}), (m:Movie {id: "m2"}) CREATE (u)-[:RATED {score: 5}]->(m);
MATCH (u:User {name: "Bob"}), (m:Movie {id: "m2"}) CREATE (u)-[:RATED {score: 4}]->(m);
MATCH (u:User {name: "Bob"}), (m:Movie {id: "m1"}) CREATE (u)-[:RATED {score: 5}]->(m);
MATCH (u:User {name: "Charlie"}), (m:Movie {id: "m1"}) CREATE (u)-[:ADDED_TO_WATCHLIST]->(m);