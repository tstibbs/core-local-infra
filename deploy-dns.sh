#!/bin/bash

set -euo pipefail

gitCommit=$(git rev-parse HEAD)
if [ -n "$(git status -s)" ]
then
	gitCommit="$gitCommit+"
fi

ssh $device mkdir -p ~/workspace/core-local-infra
scp -r dnsmasq $device:~/workspace/core-local-infra/
echo "=================="
echo "Run the following:"
echo "cd ~/workspace/core-local-infra/dnsmasq"
echo "# (optional) vim .env"
echo "docker tag \$(docker compose images -q dns) core-local-infra_dnsmasq:last-working"
echo "export commit=$gitCommit && docker compose build"
echo "docker compose down && docker compose up -d && docker compose logs --follow --timestamps"
echo "=================="
ssh $device
