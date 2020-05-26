# Multi-step dockerfile

# Fase iniziale
# FROM node:alpine as builder

# Usa un builder senza nome se deploy su AWS elastic-beanstalk
FROM node:alpine

WORKDIR '/app'

# Metti l'asterisco dopo package se deploy sy AWS elastic-beanstalk
COPY package*.json ./
RUN npm install
COPY . .

RUN npm run build


# Fase finale
FROM nginx

# Serve solo per AWS elastic-beanstalk per mappare la porta per il traffico in entrata
EXPOSE 80

# Copio sul risultato di "npm run build" deployato in /app/build nella cartella del server nginx
#COPY --from=builder /app/build /usr/share/nginx/html

# Visto che sto usando un builder senza nome, metto =0
COPY --from=0 /app/build /usr/share/nginx/html