Niveau 1 — Strings et compteurs
-------------------------------
1. Créez un compteur global de likes pour le post 100, à 0.
 - Requête : `SET tp:post:100:likes 0`
 - Réponse : `"OK"`
2. Incrémentez ce compteur 5 fois.
 - Requête : `INCRBY tp:post:100:likes 5`
 - Réponse : `5`
3. Lisez la valeur actuelle.
 - Requête : `GET tp:post:100:likes`
 - Réponse : `"5"`
4. Créez un flag maintenance:mode à 1 avec une expiration de 60 secondes.
 - Requête : `SET tp:maintenance:mode 1 EX 60`
 - Réponse : ``
5. Vérifiez son TTL restant. Que se passe-t-il après 60s ? (testez en attendant)
 - Requête : `TTL tp:maintenance:mode`
 - Réponse : ``

Niveau 2 — Hashes
-----------------
6. Créez un profil produit product:101 (nom, prix, stock, catégorie).
 - Requête : `HSET tp:product:101 nom "nom du produit" prix 1337 stock 42 catégorie "G047"`
 - Réponse : ``
7. Incrémentez le stock de 10 unités sans réécrire les autres champs.
 - Requête : `HINCRBY tp:product:101 stock 10`
 - Réponse : ``
8. Décrémentez le stock de 3 unités (vente).
 - Requête : `HDECRBY tp:product:101 stock -3`
 - Réponse : ``
9. Récupérez uniquement les champs nom et prix.
 - Requête : `HMGET tp:product:101 nom prix`
 - Réponse : ``

Niveau 3 — Lists
----------------
10. Créez une file de tâches tasks:queue avec 5 tâches.
 - Requête : `RPUSH tp:tasks:queue "task1" "task2" "task3" "task4" "task5"`
 - Réponse : ``
11. Consommez les 2 premières tâches (FIFO).
 - Requête : `LPOP tp:tasks:queue 2`
 - Réponse : ``
12. Affichez ce qu'il reste dans la file.
 - Requête : `LRANGE tp:tasks:queue 0 2`
 - Réponse : ``
13. Limitez la file aux 100 dernières tâches (recherchez LTRIM).
 - Requête : `LTRIM tp:tasks:queue -1 -100`
 - Réponse : ``

Niveau 4 — Sets
---------------
14. Créez 3 ensembles de tags pour 3 utilisateurs.
 - Requête : `SADD tp:user:1:tags "onetag" "twotag" "threetag"`
 - Réponse : ``
 - Requête : `SADD tp:user:2:tags "onetag" "mytag" "omg"`
 - Réponse : ``
 - Requête : `SADD tp:user:3:tags "onetag" "twotag" "gotag"`
 - Réponse : ``
15. Trouvez les tags communs aux 3 utilisateurs.
 - Requête : `SINTER tp:user:1:tags user:2:tags user:3:tags`
 - Réponse : ``
16. Trouvez les tags présents chez user:1 mais absents chez user:2.
 - Requête : `SDIFF tp:user:1:tags user:2:tags`
 - Réponse : ``
17. Tirez au sort un tag parmi ceux de user:1.
 - Requête : `SRANDMEMBER tp:user:1:tags`
 - Réponse : ``

Niveau 5 — Sorted Sets
----------------------
18. Ajoutez 10 joueurs à leaderboard:season1 avec des scores variés.
 - Requête : `ZADD tp:leaderboard:season1 1500 "alice" 1800 "bob" 2100 "carol" 1750 "dave" 980 "eve" 2300 "frank" 1340 "gina" 1670 "hugo" 2050 "ines" 870 "jules"`
 - Réponse : ``
19. Affichez le top 5 par score décroissant avec leurs scores.
 - Requête : `ZREVRANGE tp:leaderboard:season1 0 4 WITHSCORES`
 - Réponse : ``
20. Affichez les joueurs ayant entre 1000 et 2000 points.
 - Requête : `ZRANGEBYSCORE tp:leaderboard:season1 1000 2000 WITHSCORES`
 - Réponse : ``
21. Récupérez le rang de votre joueur préféré.
 - Requête : `ZREVRANK tp:leaderboard:season1 "carol"`
 - Réponse : ``
22. Calculez combien de joueurs ont plus de 1500 points (ZCOUNT).
 - Requête : `ZCOUNT tp:leaderboard:season1 1501 +inf`
 - Réponse : ``
23. Combinez deux Sorted Sets en un troisième : ZUNIONSTORE (recherchez la commande).
 - Requête : `ZUNIONSTORE tp:leaderboard:combined 2 leaderboard:weekly leaderboard:alltime`
 - Réponse : ``
24. Renommez la clé leaderboard:season1 en leaderboard:archive:season1 (recherchezRENAME).
 - Requête : `ZUNIONSTORE tp:leaderboard:combined 2 leaderboard:weekly leaderboard:alltime`
 - Réponse : ``
