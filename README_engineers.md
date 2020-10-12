## How does https://echo.artsy.net/Echo.json work?

This happens in 4 steps:
- The source of truth is [this repo](https://github.com/artsy/echo). That's where the latest config file exists [here](https://github.com/artsy/echo/blob/master/Echo.json).
- CircleCI does deploys using the [deploy.sh](https://github.com/artsy/echo/blob/master/scripts/deploy.sh) and some [env vars](https://app.circleci.com/settings/project/github/artsy/echo/environment-variables) and the [echo context](https://app.circleci.com/settings/organization/github/artsy/contexts/235a9fec-2662-424c-9996-e4e363a17de1)
  The deploy basically prepares the json file and uploads it to the s3 `artsy-public` bucket, under the `eigen` directory. It uploads 2 copies, one which is the main file users will be accessing, and a second copy which is mainly for reference/backup of our changes in that config file.
  The context credentials come from the `artsy-echo` IAM user, created based on [these docs](https://www.notion.so/artsy/Adding-New-IAM-Profiles-98884ccf1f0744e3862104e661445d65) and the creds are under `artsy-echo IAM Keypair` in our password manager.
- Cloudfront is used to serve the directory `s3:artsy-public/eigen` under a domain name like `xxxxx.cloudfront.net` and allowing access from echo.artsy.net.
- Cloudflare is using a CNAME to point `echo`(`.artsy.net`) to the above domain name (`xxxxx.cloudfront.net`) .
