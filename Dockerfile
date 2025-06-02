FROM ghcr.io/freecad/freecad-daily:latest

ENV DEBIAN_FRONTEND=noninteractive

# Node.js installieren
RUN apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs npm && \
    apt-get clean

WORKDIR /app

COPY . .

RUN npm install

CMD ["npm", "start"]