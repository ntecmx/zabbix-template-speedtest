#!/usr/bin/env bash

cd "$(readlink -f "$(dirname "$0")")" || exit 9

WARNING="# Autogenerated by $(basename "$0"). DO NOT EDIT MANUALLY. DO NOT INCLUDE IN PR."

# Binary
ORIG_SCRIPT=./zbx-speedtest.sh
DEB_SCRIPT=./zbx-speedtest-debian.sh
sed 's|#!/usr/bin/env sh|#!/usr/bin/env bash|' "$ORIG_SCRIPT" \
  > "$DEB_SCRIPT"
sed -i "1 a $WARNING" "$DEB_SCRIPT"

# systemd service
ORIG_SERVICE=./systemd/zabbix-speedtest.service
DEB_SERVICE=./systemd/zabbix-speedtest-debian.service
sed 's/User=zabbix-agent/User=zabbix/' "$ORIG_SERVICE" > "$DEB_SERVICE"
sed -i "1s;^;$WARNING\n;" "$DEB_SERVICE"