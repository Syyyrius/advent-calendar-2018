#!/bin/bash
set -e
cat /certs/fullchain1.pem > /usr/src/app/server.pem
cat /certs/privkey1.pem >> /usr/src/app/server.pem
/usr/sbin/dnsmasq \
    -x /run/dnsmasq/dnsmasq.pid \
    -u dnsmasq \
    -7 /etc/dnsmasq.d,.dpkg-dist,.dpkg-old,.dpkg-new \
    --local-service \
    --trust-anchor=.,19036,8,2,49aac11d7b6f6446702e54a1607371607a1a41855200fd2ce1cdde32f24e8fb5 \
    --trust-anchor=.,20326,8,2,e06d44b80b8f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d \
    -C /usr/src/app/dnsmasq.conf
/usr/bin/socat openssl-listen:5353,method=dtls1,reuseaddr,fork,cert=/usr/src/app/server.pem,cafile=/certs/fullchain1.pem,verify=0 udp-sendto:localhost:53