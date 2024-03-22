# Use the specified Cloudron base image
FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4

ARG VERSION=2.6.26

RUN apt update && apt install -y expect nodejs npm git 

RUN mkdir -p /app/code
WORKDIR /app/code

RUN git clone https://github.com/hodlerhacks/balance-bot-v2 /app/code
RUN npm install
RUN npm install fs-extra prompt-sync

RUN which expect && expect -v

COPY install.expect .
RUN chmod +x install.expect
# RUN ./install.expect

COPY start.sh /app/code/

CMD [ "/app/code/start.sh" ]
