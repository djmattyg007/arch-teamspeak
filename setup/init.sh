#!/bin/bash

# If TS_UID not specified then use default UID for user teamspeak
if [[ -z "${TS_UID}" ]]; then
    TS_UID="99"
fi

# If TS_GID not specifed then use default GID for group teamspeak
if [[ -z "${TS_GID}" ]]; then
    TS_GID="100"
fi

# Set user teamspeak to specified user ID (non unique)
usermod -o -u "${TS_UID}" teamspeak
echo "[info] Env var TS_UID defined as ${TS_UID}"

# Set group teamspeak to specified group ID (non unique)
groupmod -o -g "${TS_GID}" teamspeak
echo "[info] Env var TS_GID defined as ${TS_GID}"

# set permissions for /config volume mapping
echo "[info] Setting permissions recursively on /data..."
chown -R "${TS_UID}":"${TS_GID}" /data
chmod -R ug+rwX /data

# set permissions inside container
#chown -R "${PUID}":"${PGID}" /usr/bin/ts3server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/ /home/nobody
#chmod -R ug+rwX /usr/bin/ts3server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/ /home/nobody

cd /data
source /etc/default/teamspeak3-server
source /data/teamspeak3.conf
exec 2>&1
exec chpst -u teamspeak /usr/bin/ts3server $TS_ARGS $EXTRA_TS_ARGS
