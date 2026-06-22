Partie 5
VOTRE TOUR — Exercice 1: IoT capteurs météo
Vous gérez 5 000 capteurs météo répartis en France. Chaque capteur envoie une mesure par minute
(température, humidité, pression).
Requêtes attendues :
- Q1 : Historique d'un capteur sur un mois
- Q2 : Mesures les plus récentes (les 10 dernières) d'un capteur
- Q3 : Toutes les mesures d'une journée pour une région donnée
Travail demandé :
1. Calculez le volume de données par an : 5000 capteurs × 60 mesures/h × 24h × 365j.
2. Proposez une modélisation avec bucketing temporel (partition par jour ou par mois ?).
3. Pour chaque table, justifiez le choix de la partition key.
4. Estimez la taille d'une partition typique avec votre modélisation.
5. Bonus : que se passerait-il avec PRIMARY KEY (sensor_id, timestamp) ?


VOTRE TOUR — Exercice 2 : Réseau social messages
Vous gérez les messages privés d'un réseau social. Chaque conversation a 2 utilisateurs et des centaines
voire milliers de messages.
Requêtes attendues :
- Q1 : Tous les messages d'une conversation entre 2 users, du plus récent au plus ancien
- Q2 : Les conversations actives d'un utilisateur (par ordre de dernier message)
- Q3 : Recherche d'un message dans une conversation par mot-clé (bonus)
Travail demandé :
1. Modélisez les tables pour Q1 et Q2.
2. Réfléchissez : comment représenter une conversation à deux participants ? Par convention (user1_id <
user2_id) ou par un UUID dédié ?
3. Pour la pagination des messages anciens, comment faire ?
4. Pour Q3 (recherche par mot-clé), expliquez pourquoi Cassandra n'est pas adaptée et quelle techno
utiliser à la place.



VOTRE TOUR — Exercice 3 : E-commerce - logs de visites
Vous loggez chaque visite de page produit sur un e-commerce :
- 100 000 produits
- 1 million de visites par jour, réparties inégalement (certains produits font 10 vues/jour, d'autres 50 000)
Requêtes attendues :
- Q1 : Toutes les visites d'un produit donné sur la dernière semaine
- Q2 : Top 10 des produits les plus visités sur une journée
- Q3 : Toutes les visites d'un utilisateur (audit RGPD)
Travail demandé :
1. Pour Q1, attention aux produits stars qui font 50 000 vues/jour : risquez-vous une partition trop grosse ?
Comment l'éviter ?
2. Pour Q2 (top 10 produits/jour), expliquez pourquoi Cassandra n'est pas adaptée à cette requête « pure »
et proposez une alternative (pré-agrégation, Redis sorted set, ou Spark sur Cassandra).
3. Pour Q3, quelle est votre PRIMARY KEY ?


Partie 7
VOTRE TOUR — Requêtes CQL à produire
Pour chaque demande, écrivez la requête CQL dans une cellule cassandra-web, testez, et notez dans
votre fichier mes_requetes_cql.md.
Niveau 1 — SELECT basiques (sur vos données existantes)
1. Listez tous les passages de la station S002 le 15/09/2025.
2. Listez les 3 derniers passages de la station S001 le 15/09/2025.
3. Listez les passages entre 9h et 18h pour une station + un jour donnés.
4. Comptez le nombre de passages d'une station un jour donné (COUNT(*)).
Niveau 2 — Requêtes sur user_passages
5. Listez tous les passages d'un utilisateur donné (toutes dates confondues).
6. Listez les passages d'un utilisateur sur les 7 derniers jours.
7. Quels sont les 5 derniers passages d'un utilisateur ?
Niveau 3 — INSERT, UPDATE, DELETE
8. Insérez un nouveau passage à l'instant now() pour une station/utilisateur de votre choix.
9. Mettez à jour un passage existant : changez son event_type de rent à return (indice : utilisez UPDATE,
mais en CQL c'est en fait un UPSERT).
10. Supprimez un passage précis (DELETE avec PRIMARY KEY complète).
Niveau 4 — Compteurs
11. Incrémentez le compteur total_passages de daily_station_stats pour S001/aujourd'hui.
12. Lisez le compteur après plusieurs incréments.
13. Que se passe-t-il si vous essayez de mettre total_passages = 100 directement ? (indice : un type counter
ne se modifie que par incrément/décrément)
Niveau 5 — IN clause et bornes multiples
14. Listez les passages des stations S001 ET S002 le 15/09/2025 (indice : IN (...)).
15. Listez les passages d'une station sur 3 jours consécutifs (15, 16, 17 septembre).
Bonus
16. Essayez SELECT * FROM station_passages WHERE event_type = 'rent'; — quel message d'erreur ?
Comment résoudre proprement ?
17. Quelle table créeriez-vous pour répondre à la question « tous les passages de type 'rent' d'une station un
jour donné » sans ALLOW FILTERING ?