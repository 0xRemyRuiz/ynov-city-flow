YNOV-CITY-FLOW
==============


File structure
--------------
```text
	README.md (présentation, équipe, lancement)
	docker-compose.yml (orchestration des 4 bases)
	.env.example (variables d'environnement type)
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
			init.sh (peuplement initial)
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
