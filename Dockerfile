FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 python3-pip git curl wget \
    freecad freecad-common freecad-runtime freecad-python3 \
    nodejs npm && \
    apt-get clean

WORKDIR /app
COPY . .
RUN npm install

CMD ["npm", "start"]