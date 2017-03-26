# Scripts to bring up a CoreOS cluster
Scripts currently assume to be run on a current macOS; cluster is created as VMs in DigitalOcean

## Local CA
Creates and stores local CA certificates under localCA/certs. Config information is kept in 2 .json files in localCA
```
sh ./init-CA.sh
```

## Links
  - https://blog.cloudflare.com/how-to-build-your-own-public-key-infrastructure/
  - https://github.com/cloudflare/cfssl
