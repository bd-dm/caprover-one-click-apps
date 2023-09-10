FROM restic/restic

ENV CRON_BACKUP_SCHEDULE=${CRON_BACKUP_SCHEDULE:-"0 2 * * *"}
ENV CRON_CLEANUP_SCHEDULE=${CRON_CLEANUP_SCHEDULE:-"0 3 * * *"}
ENV KEEP_BACKUPS=${KEEP_BACKUPS:-15}
ENV BACKUP_FOLDERS=${BACKUP_FOLDERS}
ENV VPN_CONFIG_PATH=${VPN_CONFIG_PATH}

RUN mkdir /backup
VOLUME /backup

WORKDIR /app
COPY start.sh . 
RUN chmod +x start.sh

RUN apt update
RUN apt install wireguard

VOLUME /backup

ENTRYPOINT []
CMD ["sh", "start.sh"]
