if [ ! -f /opt/couchdb/data/__dbsetup ]; then
  echo "Creating config: user: ${DB_USER}. Password: ${DB_PASS}. Bind address: 0.0.0.0"
  crudini --set /opt/couchdb/etc/local.ini admins ${DB_USER} ${DB_PASS}
  crudini --set /opt/couchdb/etc/local.ini chttpd bind_address 0.0.0.0
  touch /opt/couchdb/data/__dbsetup
else
  echo "Config is already exists!"
fi

echo Database started!
/opt/couchdb/bin/couchdb