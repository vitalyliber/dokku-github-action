# Dokku for GitHub Actions

Deploy an App to your Dokku server.

This action will deploy the Application to your Dokku server via SSH.

## Usage

To use the action simply add the following lines to your `.github/workflows/main.yml`

```
name: CD

on:
  push:
    branches:
      - master
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: Dokku deploy
      uses: vitalyliber/dokku-github-action@v6.2
      env:
        PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
        HOST: ${{ secrets.HOST }}
        PROJECT: ${{ secrets.PROJECT }}
        APP_CONFIG: ${{ secrets.APP_CONFIG }}
```

### Required Secrets

You'll need to provide some env to use the action. 
Set them to the Project Secrets:

`Settings -> Secrets -> Actions -> New Repository Secret`

- **PRIVATE_KEY**: Your SSH private key to access to Dokku. Get it via command: `pbcopy < ~/.ssh/id_rsa`.
- **HOST**: The host or IP of the Dokku server. ie, `your.site.com` or `192.168.1.1`.
- **PROJECT**: Dokku project name.

### Optional Environments

You can optionally provide the following:

- **PORT**: Port of the sshd listen to, `22` is set by default.
- **FORCE_DEPLOY**: Force push the project to dokku, e.g. `FORCE_DEPLOY=true`
- **HOST_KEY**: The results of running `ssh-keyscan -t rsa $HOST`. Use this if you want to check that the host you're deploying to is the right one (e.g. has the same keys).
- **APP_CONFIG**: Set dokku config through github secrets. Example: `RAILS_MAX_THREADS=25 SECRET_KEY_BASE=xyz123&$%`.
- **BRANCH**: The ability to deploy from a non-master branch.

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
