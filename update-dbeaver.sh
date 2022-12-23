#!/bin/bash

SED_Parameter+='s@^.*/files/\([.0-9]*\)/dbeaver-ce-[.0-9]*-stable.x86_64.rpm.*$@\1@'

APPDATA_FOLDER="appdata"
REPO_FOLDER="$APPDATA_FOLDER/repo"

mkdir -p "$REPO_FOLDER/x86_64"

LATEST=$(curl -s -I HEAD "https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm" | grep -E '^Location:' | sed -e "$SED_Parameter")

echo "Got latest DBeaver Version: $LATEST"

touch "$APPDATA_FOLDER/version-dbeaver"
if [ "$LATEST" = "$(cat $APPDATA_FOLDER/version-dbeaver)" ]; then
    echo "Already got that Version, skipping"
    exit
fi

curl -s --fail -L -o "$REPO_FOLDER/x86_64/dbeaver-ce-$LATEST-stable.x86_64.rpm" "https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm"

echo "$LATEST" > $APPDATA_FOLDER/version-dbeaver
echo "Updated saved DBeaver Version"