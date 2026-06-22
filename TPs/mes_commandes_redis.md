Niveau 1 — Strings et compteurs
-------------------------------
1. Créez un compteur global de likes pour le post 100, à 0.
	`SET post:100:likes 0`
2. Incrémentez ce compteur 5 fois.
	`INCRBY post:100:likes 5`
3. Lisez la valeur actuelle.
	`GET post:100:likes`
4. Créez un flag maintenance:mode à 1 avec une expiration de 60 secondes.
	`SET maintenance:mode 1 EX 60`
5. Vérifiez son TTL restant. Que se passe-t-il après 60s ? (testez en attendant)
	`TTL maintenance:mode`

Niveau 2 — Hashes
-----------------
6. Créez un profil produit product:101 (nom, prix, stock, catégorie).
	`HSET product:101 nom "nom du produit" prix 1337 stock 42 catégorie "G047"`
7. Incrémentez le stock de 10 unités sans réécrire les autres champs.
	`HINCRBY product:101 stock 10`
8. Décrémentez le stock de 3 unités (vente).
	`HDECRBY product:101 stock -3`
9. Récupérez uniquement les champs nom et prix.
	`HMGET product:101 nom prix`

Niveau 3 — Lists
----------------
10. Créez une file de tâches tasks:queue avec 5 tâches.
	`RPUSH tasks:queue "task1" "task2" "task3" "task4" "task5"`
11. Consommez les 2 premières tâches (FIFO).
	`LPOP tasks:queue 2`
12. Affichez ce qu'il reste dans la file.
	`LRANGE tasks:queue 0 2`
13. Limitez la file aux 100 dernières tâches (recherchez LTRIM).
	`LTRIM tasks:queue -1 -100`

Niveau 4 — Sets
---------------
14. Créez 3 ensembles de tags pour 3 utilisateurs.
	`SADD user:1:tags "onetag" "twotag" "threetag"`
	`SADD user:2:tags "onetag" "mytag" "omg"`
	`SADD user:3:tags "onetag" "twotag" "gotag"`
15. Trouvez les tags communs aux 3 utilisateurs.
`SINTER user:1:tags user:2:tags user:3:tags`
16. Trouvez les tags présents chez user:1 mais absents chez user:2.
`SDIFF user:1:tags user:2:tags`
17. Tirez au sort un tag parmi ceux de user:1.
`SRANDMEMBER user:1:tags`

Niveau 5 — Sorted Sets
----------------------
18. Ajoutez 10 joueurs à leaderboard:season1 avec des scores variés.
`ZADD leaderboard:season1 1500 "alice" 1800 "bob" 2100 "carol" 1750 "dave" 980 "eve" 2300 "frank" 1340 "gina" 1670 "hugo" 2050 "ines" 870 "jules"`
19. Affichez le top 5 par score décroissant avec leurs scores.
`ZREVRANGE leaderboard:season1 0 4 WITHSCORES`
20. Affichez les joueurs ayant entre 1000 et 2000 points.
`ZRANGEBYSCORE leaderboard:season1 1000 2000 WITHSCORES`
21. Récupérez le rang de votre joueur préféré.
`ZREVRANK leaderboard:season1 "carol"`
22. Calculez combien de joueurs ont plus de 1500 points (ZCOUNT).
`ZCOUNT leaderboard:season1 1501 +inf`
23. Combinez deux Sorted Sets en un troisième : ZUNIONSTORE (recherchez la commande).
`ZUNIONSTORE leaderboard:combined 2 leaderboard:weekly leaderboard:alltime`
24. Renommez la clé leaderboard:season1 en leaderboard:archive:season1 (recherchez
RENAME).
`ZUNIONSTORE leaderboard:combined 2 leaderboard:weekly leaderboard:alltime`
