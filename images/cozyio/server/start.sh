sh /etc/create-config.sh

parallel -j 3 -- 'sh /etc/start-db.sh' 'sudo -u cozy-stack cozy-stack serve' 'sh /etc/create-instance.sh'