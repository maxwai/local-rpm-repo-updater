#!/bin/bash

cd /app || return

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

runuser -u abc -- ./update-zoom.sh
runuser -u abc -- ./update-dbeaver.sh
runuser -u root -- ./update-repo.sh