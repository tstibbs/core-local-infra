#!/bin/bash

set -euo pipefail

gitCommit=$(git rev-parse HEAD)
if [ -n "$(git status -s)" ]
then
	gitCommit="$gitCommit+"
fi

ssh $device mkdir -p ~/workspace/core-local-infra
scp -r proxy shared home-assistant $device:~/workspace/core-local-infra/
ssh $device mkdir -p ~/workspace/core-local-infra/dnsmasq
scp -r dnsmasq/docker-compose.yml dnsmasq/Dockerfile $device:~/workspace/core-local-infra/dnsmasq/
echo "=================="
echo "Run the following:"
echo "cd ~/workspace/core-local-infra/shared"
echo "echo $gitCommit > code.version"
echo "docker compose up -d"
echo "cd ~/workspace/core-local-infra/dnsmasq"
echo "(optional) vim dnsmasq.conf"
echo "echo $gitCommit > code.version"
echo "docker compose up -d"
echo "cd ~/workspace/core-local-infra/proxy"
echo "docker tag \$(docker compose images -q core-local-infra_proxy) core-local-infra_proxy:last-working"
echo "export commit=$gitCommit && docker compose build"
echo "docker compose down && docker compose up -d && docker compose logs --follow --timestamps"
echo "=================="
ssh $device
