#!/bin/bash

set -e

/usr/local/bin/docker-entrypoint.sh cassandra -f &
CASSANDRA_PID=$!

echo 'Attente du démarrage complet de Cassandra...';

until cqlsh $(hostname) 9042 -e 'describe cluster' > /dev/null 2>&1; do
	sleep 3;
done;

echo 'Cassandra est prêt ! Injection du schéma...';
cqlsh $(hostname) 9042 -f /tmp/init.cql;
echo 'Peuplement terminé avec succès !';


# # 2. Importer massivement le CSV
# cqlsh -e "COPY dev_keyspace.sensor_history_by_minute (uuid, date, minute, temperature, humidite, pression) FROM '/scripts/data.csv' WITH HEADER=FALSE;"

wait "$CASSANDRA_PID"
