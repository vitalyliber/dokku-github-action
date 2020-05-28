#!/bin/sh
# Tries to deploy to a dokku project using the docker image and entrypoint.
# Use this as a way to test that the action works.
#
# Make a copy of this file called _run.sh and fill in the env vars in the copy.
# _run.sh is gitignored so you won't accidently commit your SSH keys.

# Set these as you would expect to set them when using the action
export HOST=
export PROJECT=
export BRANCH=

# An absolute path to a git repo on your local machine that can be pushed to dokku
export LOCAL_REPO=
# An absolute path to the private key that can be used to deploy this project
PRIVATE_KEY=
PRIVATE_KEY=$(cat $PRIVATE_KEY)
export PRIVATE_KEY

# This grabs the current host key for HOST
HOST_KEY=$(ssh-keyscan -t rsa "$HOST" 2> /dev/null)
export HOST_KEY

runtest() {
    echo "Running $1"
    PASS_CODE="${2-0}"
    "./tests/$1.sh" > "./tests/$1.log" 2>&1
    CODE="$?"
    if [ "$CODE" = "$PASS_CODE" ]; then
        echo "  Passed!"
    else
        echo "  Failed (exit code was $CODE not $PASS_CODE)"
    fi
}

echo "Building docker image"
docker build --tag dokku-github-action . > "./tests/build.log" 2>&1

runtest "host_key_fails" 128
runtest "host_key_skipped"
runtest "host_key_works"
runtest "force_deploy"
