# Dokku for GitHub Actions

Deploy a master branch to your Dokku server.

This action will deploy the master branch to your Dokku server via SSH.

## Usage

To use the action simply add the following lines to your `.github/workflows/main.yml`

```
name: CD

on:
  push:
    branches:
      - master

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: Dokku deploy
      uses: vitalyliber/dokku-github-action@v4.0
      env:
        PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
        HOST: casply.com
        PROJECT: kawaii
```

### Required Secrets

You'll need to provide some secrets to use the action.

- **PRIVATE_KEY**: Your SSH private key.

### Required Environments

You'll need to provide some env to use the action.

- **HOST**: The host the action will SSH to run the git push command. ie, `your.site.com`.
- **PROJECT**: The project is Dokku project name.
- **PORT**: Port of the sshd listen to, `22` is set by default.

### Optional Environments

You can optionally provide the following:

- **FORCE_DEPLOY**: Force push the project to dokku, e.g. `FORCE_DEPLOY=true`
- **HOST_KEY**: The results of running `ssh-keyscan -t rsa $HOST`. Use this if you want to check that the host you're deploying to is the right one (e.g. has the same keys).

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
