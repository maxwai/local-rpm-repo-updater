#!/bin/bash

cd /app || return

runuser -u abc -- ./update-zoom.sh
runuser -u abc -- ./update-dbeaver.sh
./update-repo.sh