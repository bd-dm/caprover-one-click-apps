FROM ubuntu:20.04

ENV DB_HOST=${DB_HOST}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}
ENV COZY_PORT=${COZY_PORT}
ENV COZY_ADMIN_PORT=${COZY_ADMIN_PORT}
ENV COZY_ADMIN_EMAIL=${COZY_ADMIN_EMAIL}
ENV COZY_ADMIN_PASSWORD=${COZY_ADMIN_PASSWORD}
ENV DOMAIN=${DOMAIN}
ENV APPS=${APPS}
ENV LOCALE=${LOCALE}
ENV TIMEZONE=${TIMEZONE}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt -y install nodejs imagemagick libprotobuf-c1 fonts-lato git wget sudo moreutils

RUN wget -O /tmp/go1.20.5.linux-amd64.tar.gz https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzvf /tmp/go1.20.5.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin"

RUN git clone https://github.com/cozy/cozy-stack.git /opt/cozy-stack
RUN chown ${USER}: /opt/cozy-stack
RUN git -C /opt/cozy-stack checkout origin/master

WORKDIR /opt/cozy-stack
RUN ./scripts/build.sh release $(go env GOPATH)/bin/cozy-stack
RUN addgroup --quiet --system cozy
RUN adduser --quiet --system --home /var/lib/cozy \
                 --no-create-home \
                 --ingroup cozy cozy-stack

RUN install -o root -g root -m 0755 -T \
                 $(go env GOPATH)/bin/cozy-stack /usr/bin/cozy-stack
RUN sh -c 'cozy-stack completion bash > /etc/bash_completion.d/cozy-stack'
RUN ["/bin/bash", "-c", "source /etc/bash_completion.d/cozy-stack"]
RUN install -o root -g root -m 0755 -d /etc/cozy
RUN install -o root -g cozy -m 0750 -d /var/log/cozy
RUN install -o cozy-stack -g cozy -m 750 -d /usr/share/cozy
RUN install -o cozy-stack -g cozy -m 750 \
                 /opt/cozy-stack/scripts/konnector-node16-run.sh \
                 /usr/share/cozy/konnector-node16-run.sh
RUN install -o cozy-stack -g cozy -m 750 -d /var/lib/cozy

COPY ./create-config.sh /etc/create-config.sh
COPY ./create-instance.sh /etc/create-instance.sh
COPY ./start.sh /etc/start.sh
RUN chmod +x /etc/create-config.sh
RUN chmod +x /etc/create-instance.sh
RUN chmod +x /etc/start.sh

VOLUME /etc/cozy

EXPOSE $COZY_PORT
EXPOSE $COZY_ADMIN_PORT

CMD ["sh", "/etc/start.sh"]