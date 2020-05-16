#!/bin/sh

docker run \
    --env "BRANCH=$BRANCH" \
    --env "PRIVATE_KEY=$PRIVATE_KEY" \
    --env "HOST=$HOST" \
    --env "HOST_KEY=$HOST_KEY" \
    --env "PROJECT=$PROJECT" \
    --workdir "/repo" \
    --volume "$LOCAL_REPO:/repo" \
    dokku-github-action
