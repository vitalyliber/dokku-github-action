# Dokku for GitHub Actions

Deploy a master branch to your Dokku server.

This action will deploy the master brunch to your Dokku server via SSH.

## Usage

To use the action simply add the following lines to your `.github/main.workflow`

```
action "Run deploy script" {
  uses = "vitalyliber/dokku-github-action@master"
  env = {
      HOST = "casply.com",
      PROJECT = "kawaii",
    }
  secrets = [
    "PRIVATE_KEY",
    "PUBLIC_KEY",
  ]
}
```

#### Examples

* ```args = "/opt/deploy/run"```
* ```args = "touch ~/.reload"```

### Required Secrets

You'll need to provide some secrets to use the action.

* **PRIVATE_KEY**: Your SSH private key.
* **PUBLIC_KEY**: Your SSH public key.

### Required Secrets

You'll need to provide some env to use the action.

* **HOST**: The host the action will SSH to to run the git push command. ie, `your.site.com`.
* **PROJECT**: The project is Dokku project name.

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).