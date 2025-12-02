#!/bin/bash

PROJECT_NAME="strapi-gki-dev"
COMPOSE_FILE="docker-compose.dev.yml"

echo "Membangun dan menjalankan ulang [DEV] Strapi dan MySQL..."

# Build dan jalankan ulang kontainer dengan mengaktifkan cache
docker compose -f docker-compose.dev.yml -p strapi-gki-dev up -d --build --force-recreate

echo "---"
echo "Mengecek status kontainer DEV..."
docker compose -f docker-compose.dev.yml -p strapi-gki-dev ps

echo "Strapi DEV sudah berjalan di: http://localhost:1337"