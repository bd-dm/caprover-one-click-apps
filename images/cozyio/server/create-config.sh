if [ -f /etc/cozy/cozy.yml ]; then
    echo Config already exists!
    exit 0
fi

echo Creating config...

COZY_ADMIN_PASSPHRASE=${COZY_ADMIN_PASSWORD} cozy-stack config passwd /etc/cozy/cozy-admin-passphrase
chown cozy-stack:cozy /etc/cozy/cozy-admin-passphrase
cozy-stack config gen-keys /etc/cozy/vault
chown cozy-stack:cozy /etc/cozy/vault.enc /etc/cozy/vault.dec
chmod 0600 /etc/cozy/vault.enc /etc/cozy/vault.dec
tee -a /etc/cozy/cozy.yml << END
host: 0.0.0.0
port: ${COZY_PORT}

admin:
  host: 0.0.0.0
  port: ${COZY_ADMIN_PORT}

couchdb:
  url: http://${DB_USER}:${DB_PASS}@${DB_HOST}:5984/

fs:
  url: file:///var/lib/cozy

vault:
  credentials_encryptor_key: /etc/cozy/vault.enc
  credentials_decryptor_key: /etc/cozy/vault.dec

konnectors:
  cmd: /usr/share/cozy/konnector-node16-run.sh

log:
  level: info
  syslog: false

registries:
  default:
  - https://apps-registry.cozycloud.cc/selfhosted
  - https://apps-registry.cozycloud.cc/banks
  - https://apps-registry.cozycloud.cc/
END
chown cozy-stack:cozy /etc/cozy/cozy.yml
chmod 0644 /etc/cozy/cozy.yml