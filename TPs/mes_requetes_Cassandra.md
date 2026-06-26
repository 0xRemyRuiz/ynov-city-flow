VOTRE TOUR — Exercice 1: IoT capteurs météo
-------------------------------------------
Vous gérez 5 000 capteurs météo répartis en France. Chaque capteur envoie une mesure par minute
(température, humidité, pression).
Modélisation de la table :
```CQL
CREATE TABLE sensor_history_by_minute (
    uuid uuid,
    date text,       // Format "aaaammjj"
    mois text,       // Format "aaaamm"
    minute smallint,
    temperature float,
    humidite tinyint,
    pression smallint,
    PRIMARY KEY ((uuid), date, mois, minute)
) WITH CLUSTERING ORDER BY (date ASC, mois ASC, minute ASC);
```
Requêtes attendues :
- Q1 : Historique d'un capteur sur un mois
 - Requête :
```CQL
SELECT date, temperature, humidite, pression
FROM sensor_history_by_minute
WHERE uuid = 7c9e6679-7425-40de-944b-e07fc1f90ae7
  AND mois = '202606';
```
 - Réponse :
```
  date     | temperature | humidite | pression
----------+-------------+----------+----------
 20260626 |        22.6 |       55 |     1012
 20260626 |        22.7 |       56 |     1012
 20260626 |        22.9 |       56 |     1012
 20260626 |          23 |       55 |     1013
 20260626 |        23.2 |       54 |     1013
 20260626 |        23.3 |       54 |     1013
 20260626 |        23.4 |       53 |     1013
 20260626 |        23.6 |       53 |     1014
 20260626 |        23.7 |       52 |     1014
 20260626 |        23.8 |       51 |     1014

(10 rows)
```
- Q2 : Mesures les plus récentes (les 10 dernières) d'un capteur
 - Requête :
```CQL
SELECT minute, temperature, humidite, pression
FROM sensor_history_by_minute
WHERE uuid = 7c9e6679-7425-40de-944b-e07fc1f90ae7
  AND mois = '202606'
ORDER BY date DESC, minute DESC
LIMIT 10;
```
 - Résultat :
```
 minute | temperature | humidite | pression
--------+-------------+----------+----------
    930 |        25.3 |       49 |     1014
    630 |        22.8 |       59 |     1013
    900 |        24.9 |       53 |     1013
    540 |        20.8 |       66 |     1013
    990 |        25.7 |       50 |     1013
    450 |          20 |       70 |     1013
    930 |        25.1 |       52 |     1013
    570 |        21.3 |       64 |     1012
    810 |        23.7 |       57 |     1013
    390 |        18.9 |       72 |     1012

(10 rows)
```
- Q3 : Toutes les mesures d'une journée pour une région donnée
```CQL
SELECT heure, minute, uuid, temperature
FROM measures_by_region
WHERE region = 'ile-de-france' AND date = '20260626'
  AND heure IN (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23);
```
 - Résultat :
```
 heure | minute | uuid                                 | temperature
-------+--------+--------------------------------------+-------------
    15 |    900 | 6a2f41a3-c54c-fce8-32d2-000000000001 |          25
    15 |    930 | 7c9e6679-7425-40de-944b-e07fc1f90ae7 |        25.3

(2 rows)
```
Travail demandé :
1. Calculez le volume de données par an : 5000 capteurs × 60 mesures/h × 24h × 365j.
 - Réponse : Le résultat de la multiplication donne 2 628 000 000 de requête. En imaginant que l'on a 5 colonnes de données régulières minute (smallint), température (float), humidité (tinyint), pression (smallint), mois (text de taille 6) et 2 colonnes indexées avec la date (text de taille 8) et un uuid (uuid). On obtient le calcul `2 + 4 + 1 + 2 + 6 + 8 + 16 + 15 × 5 + 23 = 136`. Le 15 est l'overhead constant par colonne et le 23 l'overhead constant par ligne. Ensuite il suffit de faire `136 × 2 628 000 000 = 357 408 000 000 octets` et donc 357 giga octets. A cela il faut rajouter le coût de la clé de cluster qui est non négligeable et si l'on choisissait la date comme clé de cluster on aurait 16 octets par ligne en plus et donc cela devrait rajouter environ 36Go.
 Ceci est une mesure avant compression. La compression peut varier de 50% à 80% en fonction des données et des algorithmes utilisés. La compaction elle, n'intervient que dans un contexte d'amélioration de la vitesse et peut donc prendre de +5% à +100% d'espace de stockage ! Idemme, le facteur de redondance multiplie d'autant l'espace pris (si RF = 3 alors 393 × 3).
2. Proposez une modélisation avec bucketing temporel (partition par jour ou par mois ?).
 - Réponse : Le bucket journalier (date en partition) nous aurait obligé à scanner 30 partitions au lieu d'une seule. Le bucket annuel aurait fait exploser la taille de partition. Le bucket par mois est le meilleur, il permettrait d'améliorer notre table pour limiter la taille d'une partition à 1 mois de données.
```CQL
PRIMARY KEY ((uuid, mois), date, minute)
WITH CLUSTERING ORDER BY (date ASC, minute ASC);
```
3. Pour chaque table, justifiez le choix de la partition key.
 - Réponse : Pour notre table 1 (sensor_history_by_minute) le "uuid" distribue les écritures sur tout le cluster (5000 valeurs distinctes hashées → pas de hot partition). Et si on prend en compte notre amélioration, la clé "mois" limite la taille de partition dans le temps.
 Pour la table 2 (measures_by_region) on a choisi "region" pour pouvoir faire la requête Q3 puisque contrairement au SQL qui permet d'adapter la requête, Cassandra demande d'adapter la base quite à dupliquer de la données. Les clés "date" et "heure" permettent de limiter dans le temps.
4. Estimez la taille d'une partition typique avec votre modélisation.
 - Réponse : Pour la table 1 pour 1 cpateur pour 1 mois on aurait 60 mesures/h × 24h × 30j = 43 200 lignes. Si l'on multiplie par 136 (on reprend notre estimation précédente même si on a changé notre schéma entre temps) et on obtient 5 848 000 donc 5,8Mo. Pour la table 2 on peut imaginer qu'on serait sur quelque chose de l'ordre de 150 octet par ligne et si l'on pose pour 1 région sur 1 heure  5000 capteurs ÷ 13 régions × 60 minutes = 23 100 lignes et donc on aurait environ 3 465 000 soit 3,5Mo.
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