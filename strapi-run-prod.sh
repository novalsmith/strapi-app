#!/bin/bash

PROJECT_NAME="strapi-gki-prod"
COMPOSE_FILE="docker-compose.prod.yml"

echo "Membangun dan menjalankan ulang [Prod] Strapi dan MySQL..."

# Build dan jalankan ulang kontainer
docker compose -f $COMPOSE_FILE -p $PROJECT_NAME up -d --build --force-recreate

echo "---"
echo "Mengecek status kontainer Prod..."
docker compose -f $COMPOSE_FILE -p $PROJECT_NAME ps

# Note: IP 147.93.81.33 adalah IP VPS Anda.
# Port yang Anda gunakan adalah ${STRAPI_PORT_PROD} yang diekspos di docker-compose.prod.yml
echo "Strapi Prod sudah berjalan di: http://147.93.81.33:${STRAPI_PORT_PROD}"