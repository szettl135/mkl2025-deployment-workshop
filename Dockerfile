FROM node:20-slim
# Sobal irgendwer anderes es sieht, einen maintainer hinzufügen, damit man weiß wer es macht
LABEL maintainer="it241501@ustp-students.at"

# User solle keine aufforderungen bekommen
ENV DEBIAN_FRONTEND=noninteractive

# Jeder Run befhel baut einen Layer auf
# Deswegen macht man lieber ein concatinate con befeheln, um die Layer klein zu halten
# macht es aber schwerer zum debuggen
RUN apt update && apt upgrade -y

RUN apt install -y curl

# Jeder weitere Befehl geht von diesem dir aus
WORKDIR /usr/src/app

RUN npm i -g npm@11 typeorm

COPY package*.json ./

# verwendet nur die packga-lock.json
RUN npm ci 

COPY . .

RUN npm run build