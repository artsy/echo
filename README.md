Testing 

# echo

- **Depfu :** [![Depfu](https://badges.depfu.com/badges/433c73edca24a04a7cefd5441a84b774/count.svg)](https://depfu.com/github/artsy/echo?project_id=30287)
- **CI :** [![Build Status](https://circleci.com/gh/artsy/echo/tree/main.svg?style=shield&circle-token=f7a3e9b08ab306cd01a15da49933c0774d508ecb)](https://circleci.com/gh/artsy/echo)

[echo](http://github.com/artsy/echo) is an API service that provides remote configuration for Artsy mobile clients. It works using a json file and some scripts to upload it to s3.

⚠️ **NOTE** ⚠️: Everything in the Echo.json file is public and visible by anyone with the url below. This file should **not** be used to store/deliver any sensitive values/keys. Even if values are stored in circleci and then replaced in the final file, the values are still visible to the world.

## Meta

- **State:** production
- **Staging:** [https://echo.artsy.net/Echo.staging.json](https://echo.artsy.net/Echo.staging.json)
- **Production:** [https://echo.artsy.net/Echo.json](https://echo.artsy.net/Echo.json)
- **Github:** [https://github.com/artsy/echo/](https://github.com/artsy/echo/)
- **Point People:** [@pvinis](https://github.com/pvinis)

## Set-Up for Development

- Fork [artsy/echo](https://github.com/artsy/echo)
- Make a PR with your changes (toggle/add/remove flags)

## Killing app versions

**Eigen** has two ways to kill app versions.

- By setting a specific minimum version
- By killing a specific app version

Check docs [here](./docs/kill-versions.md) for details.

## Old Heroku Echo

**NOTE TO ARTSY STAFF**: Old versions of the app are still hitting the `echo-api-production.herokuapp.com` URL. Versions 6.7.0 and onward of the app [use an AWS S3-based approach](https://artsyproduct.atlassian.net/browse/CX-386) ([see PR](https://github.com/artsy/echo/pull/39)) but older versions are still in use by users. We have replaced the old `echo-api-production` Heroku app with a proxy to our S3 bucket approach; the app is stored on [the `heroku-proxy-to-s3` branch](https://github.com/artsy/echo/tree/heroku-proxy-to-s3), with instructions on how to deploy updates.
