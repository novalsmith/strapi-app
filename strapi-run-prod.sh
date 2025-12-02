#!/bin/bash

PROJECT_NAME="strapi-gki-prod"
COMPOSE_FILE="docker-compose.prod.yml"

echo "Membangun dan menjalankan ulang [PRODUCTION] Strapi dan MySQL..."

# Build dan jalankan ulang kontainer
docker compose -f $COMPOSE_FILE -p $PROJECT_NAME up -d --build --force-recreate

echo "---"
echo "Mengecek status kontainer PROD..."
docker compose -f $COMPOSE_FILE -p $PROJECT_NAME ps

echo "Strapi PROD service sudah berjalan."