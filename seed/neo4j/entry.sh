#!/bin/bash

# Start Neo4j in the background using the official entrypoint binary
/startup/docker-entrypoint.sh neo4j &

# Wait for Neo4j Bolt port (7687) to become available
echo "Waiting for Neo4j engine to start..."
while ! timeout 1s bash -c 'cat < /dev/null > /dev/tcp/localhost/7687' 2>/dev/null; do
    sleep 0.5
done

# Seed the data using cypher-shell (Uses default authentication info)
if [ -f /tmp/init.cypher ]; then
    echo "Seeding Neo4j Graph Database..."
    cat /tmp/init.cypher | cypher-shell -u neo4j -p cityflow2025 --database neo4j
    echo "Neo4j seeding completed successfully."
else
    echo "Warning: /tmp/init.cypher not found."
fi

# Keep the container alive by waiting on the background neo4j process
wait
