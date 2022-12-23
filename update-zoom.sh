#!/bin/bash

SED_Parameter="s@^.*/prod/\([.0-9]*\)/zoom_x86_64"
SED_Parameter+='.rpm.*$@\1@'

APPDATA_FOLDER="appdata"
REPO_FOLDER="$APPDATA_FOLDER/repo"

mkdir -p "$REPO_FOLDER/x86_64"

LATEST=$(curl -s -I HEAD "https://zoom.us/client/latest/zoom_x86_64.rpm" | grep -E '^location:' | sed -e "$SED_Parameter")

echo "Got latest Zoom Version: $LATEST"

touch "$APPDATA_FOLDER/version-zoom"
if [ "$LATEST" = "$(cat $APPDATA_FOLDER/version-zoom)" ]; then
    echo "Already got that Version, skipping"
    exit
fi

curl -s --fail -L -o "$REPO_FOLDER/x86_64/zoom-$LATEST-1.x86_64.rpm" "https://zoom.us/client/$LATEST/zoom_x86_64.rpm"

echo "$LATEST" > $APPDATA_FOLDER/version-zoom
echo "Updated saved Zoom Version"