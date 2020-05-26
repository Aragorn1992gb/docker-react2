# Multi-step dockerfile

# Fase iniziale
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build


# Fase finale
FROM ngin

# Serve solo per AWS elastic-beanstalk per mappare la porta per il traffico in entrata
EXPOSE 80

# Copio sul risultato di "npm run build" deployato in /app/build nella cartella del server nginx
#COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html