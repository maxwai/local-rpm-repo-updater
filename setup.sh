#!/bin/bash

PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

chown -R abc:abc /app

echo "export GPG_KEY_NAME='${GPG_KEY_NAME}'" >> .env
echo "export GPG_KEY_EMAIL='${GPG_KEY_EMAIL}'" >> .env