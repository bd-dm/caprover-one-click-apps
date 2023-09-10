if restic snapshots -v &> /dev/null ; then
  echo "repository is already initialized, skipping init command"
else
  echo "repository is not initialized, running init command..."
  
  restic init
fi

# Create crontab file
touch /etc/crontabs/root/cronjobs
echo "${CRON_BACKUP_SCHEDULE} restic backup /backup" >> /etc/crontabs/root/cronjobs
echo "${CRON_CLEANUP_SCHEDULE} restic forget --keep-last ${KEEP_BACKUPS}" >> /etc/crontabs/root/cronjobs

crond -f -d 8