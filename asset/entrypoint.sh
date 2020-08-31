#!/bin/bash

tail -f /etc/hosts


NAMEDCONF=/etc/named.conf

/bin/bash -c 'if [ ! "$DISABLE_ZONE_CHECKING" == "yes" ]; then /usr/sbin/named-checkconf -z "$NAMEDCONF"; else echo "Checking of zone files is disabled"; fi'
/usr/sbin/named -u named -c ${NAMEDCONF}


