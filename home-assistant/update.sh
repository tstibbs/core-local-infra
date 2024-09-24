#!/bin/bash

set -euo pipefail

newVersion=$(curl --silent -X GET "https://hub.docker.com/v2/repositories/homeassistant/home-assistant/tags/" | jq --raw-output '.results | sort_by(.last_updated) | .[].name' | grep -P '^\d+(\.\d+){2,}$' | head -n 1)
oldVersion=$(grep 'imageVersion=' .env | sed -r 's/^(imageVersion=)//')

echo "Updating from $oldVersion to $newVersion..."
#TODO only continue if there is actually a new version

backupDate=$(date +'%Y_%m_%d-%H_%M-%S')
cp .env .env.last-known-working-$backupDate

sed -i -r 's/^(imageVersion=).+$/\1'"$newVersion"'/' .env

docker compose pull
docker compose down
docker compose up -d
docker compose logs -f
