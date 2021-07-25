#!/usr/bin/env ash
# captive portal auto-login script for Vodafone Hotspot
# Copyright (c) 2021 Sven Grunewaldt (strayer@olle-orks.org)
# This is free software, licensed under the GNU General Public License v3.

# shellcheck disable=1091,2187

export LC_ALL=C
export PATH="/usr/sbin:/usr/bin:/sbin:/bin"
set -euo pipefail

if [ "$(uci_get 2>/dev/null; printf "%u" "${?}")" = "127" ]
then
	. "/lib/functions.sh"
fi

trm_useragent="$(uci_get travelmate global trm_useragent "Mozilla/5.0 (Linux x86_64; rv:80.0) Gecko/20100101 Firefox/80.0")"
trm_maxwait="$(uci_get travelmate global trm_maxwait "30")"
trm_fetch="$(command -v curl)"

# get session id
SESSION_ID=$("${trm_fetch}" https://hotspot.vodafone.de/api/v4/session --user-agent "${trm_useragent}" --silent --connect-timeout $((trm_maxwait/6)) | jq -r '.session')

# login
RESULT=$("${trm_fetch}" -H 'Content-Type: application/json' --user-agent "${trm_useragent}" --silent --connect-timeout $((trm_maxwait/6)) --request POST --data "{\"loginProfile\": 2, \"accessType\": \"termsOnly\", \"session\": \"${SESSION_ID}\"}" https://hotspot.vodafone.de/api/v4/login 2>/dev/null | jq -r '.message')

if [ "$RESULT" = "OK" ]; then
  exit 0
else
  echo "$RESULT"
  exit 1
fi

# vim: ft=sh
