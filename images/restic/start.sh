if restic snapshots -v &> /dev/null ; then
  echo "repository is already initialized, skipping init command"
else
  echo "repository is not initialized, running init command..."
  
  restic init
fi

# Create crontab file
BACKUP_FOLDERS_ARRAY=($(echo $BACKUP_FOLDERS | tr "," "\n"))
echo "Backup folders: ${BACKUP_FOLDERS}"
touch /etc/crontabs/root/cronjobs

for folder in "${!BACKUP_FOLDERS_ARRAY[@]}"
do
  echo "${CRON_BACKUP_SCHEDULE} restic backup /host/${folder}" >> /etc/crontabs/root/cronjobs
done
echo "${CRON_CLEANUP_SCHEDULE} restic forget --keep-last ${KEEP_BACKUPS}" >> /etc/crontabs/root/cronjobs

crond -f -d 8