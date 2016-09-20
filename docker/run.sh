#!/bin/sh

exec /usr/bin/goshawkdb \
  -config /etc/goshawkdb/config.json \
  -cert /etc/goshawkdb/user1.pem \
  -dir /tmp \
  -port 7894
