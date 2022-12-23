#!/bin/bash

APPDATA_FOLDER="appdata"
REPO_FOLDER="$APPDATA_FOLDER/repo"

rm -rf "$REPO_FOLDER/x86_64/repodata"

gpg --batch --quiet --import "$APPDATA_FOLDER/pgp-key.private"

touch ~/.rpmmacros
if ! grep -q "%_gpg_name $GPG_KEY_NAME <$GPG_KEY_EMAIL>" ~/.rpmmacros; then
  echo "%_gpg_name $GPG_KEY_NAME <$GPG_KEY_EMAIL>" >> ~/.rpmmacros
fi

rpmsign --quiet --addsign "$REPO_FOLDER/x86_64/"*.rpm |& \
    grep -v "warning: Could not set GPG_TTY to stdin: Inappropriate ioctl for device" | \
    grep -v "warning: $REPO_FOLDER/x86_64/.*\.rpm already contains identical signature, skipping"

createrepo -q "$REPO_FOLDER/x86_64/"

gpg --batch --quiet --detach-sign --armor "$REPO_FOLDER/x86_64/repodata/repomd.xml"

chown -R abc:abc "$REPO_FOLDER"