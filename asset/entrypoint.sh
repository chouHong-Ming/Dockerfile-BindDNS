#!/bin/bash


test -f /etc/named.rfc1912.zones || yum install -y bind bind-libs bind-chroot bind-utils
test -f /etc/named.root.key || yum install -y bind bind-libs bind-chroot bind-utils
test -f /etc/named.iscdlv.key || yum install -y bind bind-libs bind-chroot bind-utils
test -f /var/named/named.ca || cp -r /var/named-default/* /var/named
test -f /var/named/named.localhost || cp -r /var/named-default/* /var/named
test -f /var/named/named.loopback || cp -r /var/named-default/* /var/named
test -f /var/named/named.empty || cp -r /var/named-default/* /var/named


test -z $NAMED_CONF && NAMED_CONF=/etc/named.conf
test -z $LOG_LEVEL && LOG_LEVEL=6

/bin/bash -c 'if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then /usr/sbin/named-checkconf -z "$NAMEDCONF"; else echo "Checking of zone files is disabled"; fi'
/usr/sbin/named -u named -c ${NAMED_CONF} -d ${LOG_LEVEL}


tail -f /var/named/data/named.run


