#!/bin/sh
# Sets up the environment for running the tests, then runs them.
# Use this as a way to test that the action works in lots of different scenarios
#
# Make a copy of this file called _run.sh and fill in the env vars.
# _run.sh is gitignored so you won't accidently commit your SSH keys.
set -eu

docker build --tag dokku-github-action .

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
HOST_KEY=$(ssh-keyscan -t rsa "$HOST")
export HOST_KEY

./tests/host_key_fails.sh
./tests/host_key_skipped.sh
./tests/host_key_works.sh
./tests/force_deploy.sh
