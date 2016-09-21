#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
#exec /sbin/setuser root /sbin/pptpd --debug >>/var/log/pptpd.log 2>&1
#exec /usr/sbin/pptpd --fg --debug >>/var/log/pptpd.log 2>&1
exec /usr/sbin/pptpd --fg >>/var/log/pptpd.log 2>&1
