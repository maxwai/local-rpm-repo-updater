[![GitHub license](https://badgen.net/github/license/maxwai/local-rpm-repo-updater)](LICENSE)

# RPM Repo Updater Tool

The source code that I use to crawl RPM Packages from Sites that don't offer a RPM Repo and put them in a repo Folder for distribution.

## Getting Started

This is only supposed to run in a docker container.

### Needed environment variables

- `PUID` : The User ID (UID gotten from `id`) that all files should be created as, this is so that there are no permission problems outside of the docker container
- `PGID` : The Group ID (GID gotten from `id`) that all files should be created as, this is so that there are no permission problems outside of the docker container.
- `GPG_KEY_NAME` : The Name used in the GPG Key that will be used to find the correct key.
- `GPG_KEY_EMAIL` : The email used in the GPG Key that will be used to find the correct key.

### Paths

- `/app/appdata`: the appdata Folder here the rpm package versions and the private pgp key are stored. The Pgp key has to be called `pgp-key.private`
- `/app/appdata/repo`: the rpm repo Folder, there will be a subfolder with the arch name before the actual repo. Also here the public pgp key should be put for users to access to be able to verify the packages.
