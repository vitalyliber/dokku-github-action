#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"
mkdir -p "$SSH_PATH"

DEPLOY_BRANCH="${BRANCH-master}"
FORCE=$([ "$FORCE_DEPLOY" = true ] && echo "--force" || echo "")

echo "$PRIVATE_KEY" > "$SSH_PATH/deploy_key"
echo "$PUBLIC_KEY" > "$SSH_PATH/deploy_key.pub"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/deploy_key"
chmod 600 "$SSH_PATH/deploy_key.pub"

eval $(ssh-agent)
ssh-add "$SSH_PATH/deploy_key"


GIT_SSH_COMMAND="ssh -p ${PORT-22}"


if [ -n "$HOST_KEY" ]; then
    echo "$HOST_KEY" >> "$SSH_PATH/known_hosts"
    chmod 600 "$SSH_PATH/known_hosts"
else
    GIT_SSH_COMMAND="$GIT_SSH_COMMAND -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
fi

git checkout $DEPLOY_BRANCH

echo "The deploy is starting"

GIT_SSH_COMMAND="$GIT_SSH_COMMAND" git push dokku@$HOST:$PROJECT $DEPLOY_BRANCH:master $FORCE
