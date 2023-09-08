if [ ! -f /opt/couchdb/data/dbsetup ]; then
  crudini --set /opt/couchdb/etc/local.ini admins ${DB_USER} ${DB_PASS}
  crudini --set /opt/couchdb/etc/local.ini chttpd bind_address 0.0.0.0
  touch /opt/couchdb/data/dbsetup
fi

/opt/couchdb/bin/couchdb