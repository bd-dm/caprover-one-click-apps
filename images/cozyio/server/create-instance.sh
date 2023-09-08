if [ -f /etc/cozy/instance-created ]; then
    echo Instance already exists!
    exit 0
fi

echo Creating instance...
sleep 3

TMPFILE=$(mktemp /tmp/cozyXXX)
echo "Temp file for instance: ${TMPFILE}"
cozy-stack instances add --apps ${APPS} --email "${COZY_ADMIN_EMAIL}" --locale ${LOCALE} --tz "${TIMEZONE}" ${DOMAIN} | tee "${TMPFILE}"
cozy-stack apps install --domain ${DOMAIN} store registry://store/stable | tee -a "${TMPFILE}"

TOKEN=""
if [ $(grep -ic ERROR ${TMPFILE}) -eq 0 ]; then
	TOKEN=$(grep token "${TMPFILE}" | cut -f2 -d":" | tr -d '" ')
fi

echo Done!
echo "Open this url on a browser to configure your instance https://${DOMAIN}?registerToken=${TOKEN}"

rm TMPFILE
touch /etc/cozy/instance-created
