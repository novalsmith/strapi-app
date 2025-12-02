#!/bin/bash

PROJECT_NAME="strapi-gki-prod"
COMPOSE_FILE="docker-compose.prod.yml"

# --- PENTING: Memuat file .env.production secara eksplisit ---
# Ini memastikan semua variabel lingkungan (secrets) di file tersebut 
# dimuat ke dalam shell, sehingga 'docker compose' dapat membacanya 
# untuk substitusi variabel.
if [ -f ./.env.production ]; then
    echo "Memuat variabel dari .env.production..."
    source ./.env.production
else
    echo "ERROR: File .env.production tidak ditemukan!"
    exit 1
fi

echo "Membangun dan menjalankan ulang [Prod] Strapi dan MySQL..."

# Perintah Docker Compose untuk production
# Menggunakan nama project dan force-recreate untuk memastikan service diupdate
# --build: Membangun ulang image jika ada perubahan kode/config Strapi
# -d: Menjalankan kontainer di latar belakang (detached mode)
# --force-recreate: Memaksa kontainer dibuat ulang (penting untuk update volume)
docker compose -f $COMPOSE_FILE -p $PROJECT_NAME up -d --build --force-recreate

# Perintah untuk mengecek status kontainer
echo "---"
echo "Mengecek status kontainer Prod..."
docker compose -f $COMPOSE_FILE -p $PROJECT_NAME ps

# Informasi akses (menggunakan variabel dari .env.production yang telah dimuat oleh 'source')
if [ ! -z "$STRAPI_PORT_PROD" ]; then
    # Note: IP 147.93.81.33 adalah IP VPS Anda.
    # Port yang Anda gunakan adalah ${STRAPI_PORT_PROD} yang diekspos di docker-compose.prod.yml
    echo "Strapi Prod sudah berjalan di: http://147.93.81.33:${STRAPI_PORT_PROD}"
else
    echo "PERINGATAN: Variabel STRAPI_PORT_PROD tidak ditemukan. Periksa .env.production."
fi