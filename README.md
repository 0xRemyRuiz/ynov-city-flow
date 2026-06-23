YNOV-CITY-FLOW
==============

Présentation
------------

Equipe
------

Lancement
---------
Pour lancer le projet il suffit d'un `docker compose up -d`. Cela lance les bases de tp anisi que celles concernant l'application. Si on veut reset on peut `docker compose down -v` avant le compose up, toutes les données sont recréées par les fichiers de seed.
On peut se connecter à un conteneur en faisant juste `./util exec nom_du_conteneur` cette commande effectue un docker exec -it /bin/bash sur le conteneur nommé.

Structure du repo
-----------------
```text
	.gitignore
	README.md (présentation, équipe, lancement)
	TODO.md (document de soutien à l'équipe)
	docker-compose.yml (orchestration des 4 bases)
	util (script shell basique d'aide au debug)	
	docs/
		architecture.md (schéma global + justifications)
		modelisation-mongodb.md (collections + choix embed/ref)
		modelisation-redis.md (clés + structures + naming)
		modelisation-cassandra.md (tables + partition keys + justifs)
		modelisation-neo4j.md (nœuds, relations, propriétés)
	seed/
		mongodb/
			init.js (création collections + données)
		redis/
			entry.sh (peuplement initial)
			init.txt (instructions initiales)
		cassandra/
			init.cql (création keyspace + tables + données)
		neo4j/
			init.cypher (création nœuds et relations)
	TPs/ (réponses aux questions du TP)
		mes_commandes_redis.md
	queries/
		mongodb-queries.md (requêtes user stories M1-M4)
		redis-queries.md (requêtes user stories R1-R4)
		cassandra-queries.md (requêtes user stories C1-C4)
		neo4j-queries.md (requêtes user stories N1-N4)
```
