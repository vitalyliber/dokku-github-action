#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"
DEPLOY_BRANCH="${BRANCH-master}"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key.pub"

eval $(ssh-agent)
ssh-add "$SSH_PATH/deploy_key"

ssh-keyscan -t rsa $HOST >> "$SSH_PATH/known_hosts"

git checkout $DEPLOY_BRANCH

until ssh dokku@$HOST "apps:locked $PROJECT" 2>&1 | grep -q "does not exist"
do
  sleep 3
done

GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git push dokku@$HOST:$PROJECT $DEPLOY_BRANCH:master
