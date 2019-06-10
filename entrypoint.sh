#!/bin/sh -l

if [ -z "$SSH_PRIVATE_KEY" ]; then
	>&2 echo "Set SSH_PRIVATE_KEY environment variable"
	exit 1
fi

if [ -z "$SSH_URL" ]; then
	>&2 echo "Set SSH_URL  environment variable"
	exit 1
fi

mkdir -p ~/.ssh
echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

sh -c "$*"