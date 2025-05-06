# --- Etap 1: Budowanie aplikacji ---
FROM node:18-alpine AS builder

# Autor
LABEL org.opencontainers.image.authors="Andżelika Gawinkowska"
    
# Ustaw katalog roboczy
WORKDIR /app
    
# Kopiujemy tylko pliki potrzebne do zainstalowania zależności (cache-friendly)
COPY package*.json ./
    
# Instalacja zależności
RUN npm install
    
# Kopiujemy pozostałe pliki aplikacji
COPY . .
    
# --- Etap 2: Obraz produkcyjny ---
FROM node:18-alpine
    
# Autor 
LABEL org.opencontainers.image.authors="Andżelika Gawinkowska"

# Instalacja curl do sprawdzenia HEALTHCHECK
RUN apk add --no-cache curl
    
# Ustaw katalog roboczy
WORKDIR /app
    
# Kopiujemy zbudowaną aplikację z etapu buildera
COPY --from=builder /app /app
    
# Eksponujemy port (zgodnie z index.js: process.env.PORT || 3000)
EXPOSE 3000
    
# Dodajemy prosty healthcheck, który sprawdza czy aplikacja działa
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:3000 || exit 1
    
# Uruchomienie aplikacji
CMD ["npm", "start"]
    