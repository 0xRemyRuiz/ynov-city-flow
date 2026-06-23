#!/bin/sh

# Start Redis in the background
redis-server --daemonize yes

# Wait briefly until the Redis server is responsive
until redis-cli ping | grep -q "PONG"; do
  echo "Waiting for Redis to start..."
  sleep 0.5
done

INIT_FILE=/tmp/init.txt
if [ -f $INIT_FILE ]; then
  echo "Seeding Redis database..."
  redis-cli < $INIT_FILE
  redis-cli config set appendonly yes
  redis-cli save
  echo "Redis seeding completed successfully."
else
  echo "Warning: $INIT_FILE not found. No data seeded."
fi

# Gracefully stop the background server so Docker can run it in the foreground cleanly
redis-cli shutdown

exec redis-server --requirepass cityflow2025 --appendonly yes
