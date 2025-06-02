FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# System-Dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip curl wget git \
    libglu1-mesa libxrender1 libxext6 libsm6 libx11-6 && \
    apt-get clean

# Node.js installieren
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

# FreeCAD AppImage herunterladen
RUN wget -O FreeCAD.AppImage https://github.com/FreeCAD/FreeCAD-Bundle/releases/download/0.21.2/FreeCAD_0.21.2-Linux-x86_64.AppImage && \
    chmod +x FreeCAD.AppImage

COPY . .

RUN npm install

CMD ["npm", "start"]