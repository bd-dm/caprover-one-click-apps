FROM ubuntu:22.04

ENV VPN_CONFIG=${VPN_CONFIG}

RUN apt update
RUN apt install -y wireguard openresolv

RUN apt install -y ca-certificates curl gnupg
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update
RUN apt install nodejs wget iproute2 -y
RUN apt install net-tools -y
RUN apt install iptables -y
RUN apt install traceroute -y
RUN apt install iputils-ping -y
RUN apt install tcpdump -y

RUN wget -O /etc/wireguard/wg0.conf ${VPN_CONFIG}

COPY . /app
WORKDIR /app

RUN npm install

CMD ["sh", "/app/start-vpn.sh"]