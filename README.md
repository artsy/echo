# echo

**NOTE TO ARTSY STAFF**: The last deployed branch in heroku is `ash-deploy`, so any urgent fixes should be made from there. See [PLATFORM-1300](https://artsyproduct.atlassian.net/browse/PLATFORM-1300) for more information.

[echo](http://github.com/artsy/echo) is an API service that provides remote configuration for Artsy mobile clients. It works using a json file and some scripts to upload it to s3.

Meta
---

* __State:__ production
* __Staging:__ [https://echo-staging.artsy.net/Echo.json](https://echo-staging.artsy.net/Echo.json)
* __Production:__ [https://echo.artsy.net/Echo.json](https://echo.artsy.net/Echo.json)
* __Github:__ [https://github.com/artsy/echo/](https://github.com/artsy/echo/)
* __Point People:__ [@ashfurrow](https://github.com/ashfurrow), [@pvinis](https://github.com/pvinis)

Set-Up for Development
---
- Fork [artsy/echo](https://github.com/artsy/echo)
- Make a PR with your changes (toggle/add/remove flags)
