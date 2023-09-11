echo "L/sXKLD6y85GGJxPu9JXpv9AUc79HINxbR/7d3WQn0A=" > private_key
echo "Vq9GgTVgfcnOvWY0umqxCohhxFddyvUjULG5YSWWjOk=" > preshared_key

ip link add wg0 type wireguard
wg set wg0 listen-port 50000 private-key private_key \
 peer yWtsZhq3FvUEPcgTKpfzTKwfJuLBDz4U+ddP31PA2Q4= \
 preshared-key preshared_key \
 persistent-keepalive 25 \
 allowed-ips 0.0.0.0/0 \
 endpoint firezone.amsterdam.bd-dm.ru:51820
ip address add 10.3.2.44/24 dev wg0
ip link set mtu 1280 up dev wg0

node index.js