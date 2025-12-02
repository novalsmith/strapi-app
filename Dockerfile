# Dockerfile

FROM node:20-alpine AS base

# Install global Strapi CLI (optional)
# RUN npm install -g @strapi/cli

# Install dependencies yang dibutuhkan
WORKDIR /opt/strapi

# Copy files dan install dependencies
COPY my-project/package.json ./
COPY my-project/package-lock.json ./

# Install driver MySQL sebelum instalasi Strapi dependencies
RUN npm install mysql2 --prefix /opt/strapi

# Install dependencies Strapi (termasuk yang terinstal di atas)
RUN npm install

COPY . .

# Build admin panel (hanya untuk memastikan semua konfigurasi di compile)
RUN npm run build

# Command untuk development
CMD ["npm", "run", "develop"]