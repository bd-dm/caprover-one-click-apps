FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

COPY ./start.sh /etc/start.sh
RUN chmod +x /etc/start.sh

RUN apt update
RUN apt -y install curl apt-transport-https ca-certificates wget crudini

# Install cozy-couchdb
RUN wget https://apt.cozy.io/cozy-keyring.deb
RUN dpkg -i cozy-keyring.deb
RUN echo "deb https://apt.cozy.io/debian/ buster testing" > /etc/apt/sources.list.d/cozy.list
RUN apt update
RUN apt install cozy-couchdb -y

VOLUME /opt/couchdb/data
EXPOSE 5984

CMD ["sh", "/etc/start.sh"]