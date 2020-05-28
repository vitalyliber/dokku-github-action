#!/bin/sh

docker run \
    --env "BRANCH=$BRANCH" \
    --env "PRIVATE_KEY=$PRIVATE_KEY" \
    --env "HOST=$HOST" \
    --env "PROJECT=$PROJECT" \
    --workdir "/repo" \
    --volume "$LOCAL_REPO:/repo" \
    dokku-github-action
