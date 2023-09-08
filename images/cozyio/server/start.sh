sh /etc/create-config.sh

parallel -j 2 -- 'sudo -u cozy-stack cozy-stack serve' 'sh /etc/create-instance.sh'