# ----------------------------------------------------------------------
# STAGE 1: BUILDER
# Tugas: Menginstal semua dependencies (termasuk devDependencies) dan menjalankan build Strapi.
# ----------------------------------------------------------------------
    FROM node:20-alpine AS builder

    WORKDIR /opt/strapi
    
    # 1. Salin dan instal dependencies
    # Hanya menyalin file package untuk memanfaatkan cache Docker
    COPY my-project/package.json ./
    COPY my-project/package-lock.json ./
    
    # Instal driver MySQL sebelum dependencies Strapi
    RUN npm install mysql2 --prefix /opt/strapi
    
    # Instal semua dependencies
    RUN npm install
    
    # 2. Salin kode sumber dan jalankan build
    COPY my-project/ ./
    
    # Build admin panel dan kompilasi TypeScript (Wajib untuk Production)
    RUN npm run build
    
    # ----------------------------------------------------------------------
    # STAGE 2: PRODUCTION RUNTIME
    # Tugas: Membuat image final yang ringan, hanya berisi dependencies production dan hasil build.
    # ----------------------------------------------------------------------
    FROM node:20-alpine AS production
    
    WORKDIR /opt/strapi
    # Set environment ke production secara default
    ENV NODE_ENV production
    
    # Salin hanya dependencies produksi (node_modules) dari stage builder
    COPY --from=builder /opt/strapi/node_modules ./node_modules/
    # Salin hasil kompilasi (dist, admin)
    COPY --from=builder /opt/strapi/dist ./dist/
    # Salin kode sumber yang diperlukan untuk runtime (config, src, dll.)
    COPY my-project/ ./
    
    # Command default untuk menjalankan Strapi di Production
    CMD ["npm", "start"]