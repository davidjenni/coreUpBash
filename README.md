# Scripts to bring up a CoreOS cluster
Scripts currently assume to be run on a current macOS; cluster is created as VMs in DigitalOcean

## Local CA
Creates and stores local CA certificates under localCA/certs. Config information is kept in 2 .json files in localCA
```bash
sh ./init-CA.sh
```

## Environment variables
The following env variables of docker-machine are used:
  - `DIGITALOCEAN_ACCESS_TOKEN`   Personal acccess token of your [DO account](https://cloud.digitalocean.com/settings/api/tokens)
  - `DIGITALOCEAN_SSH_KEY_PATH`   Path to SSH public key to use to login to CoreOS

## Links
  - https://blog.cloudflare.com/how-to-build-your-own-public-key-infrastructure/
  - https://github.com/cloudflare/cfssl
