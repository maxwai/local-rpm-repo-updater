#!/bin/bash

docker build -t "maxwai/local-rpm-repo-updater:$1" .
docker build -t maxwai/local-rpm-repo-updater:latest .
docker push "maxwai/local-rpm-repo-updater:$1"
docker push maxwai/local-rpm-repo-updater:latest