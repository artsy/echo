# echo

[echo](http://github.com/artsy/echo) is an API service that provides remote configuration for Artsy mobile clients. It works using a json file and some scripts to upload it to s3.

⚠️ **NOTE** ⚠️: Everything in the Echo.json file is public and visible by anyone with the url below. This file should **not** be used to store/deliver any sensitive values/keys. Even if values are stored in circleci and then replaced in the final file, the values are still visible to the world.


Meta
---

* __State:__ production
* __Staging:__ [https://echo.artsy.net/Echo.staging.json](https://echo.artsy.net/Echo.staging.json)
* __Production:__ [https://echo.artsy.net/Echo.json](https://echo.artsy.net/Echo.json)
* __Github:__ [https://github.com/artsy/echo/](https://github.com/artsy/echo/)
* __Point People:__ [@ashfurrow](https://github.com/ashfurrow), [@pvinis](https://github.com/pvinis)


Set-Up for Development
---

- Fork [artsy/echo](https://github.com/artsy/echo)
- Make a PR with your changes (toggle/add/remove flags)


Old heroku echo
---

**NOTE TO ARTSY STAFF**: The last deployed branch in heroku is `ash-deploy`, so any urgent fixes should be made from there. See [PLATFORM-1300](https://artsyproduct.atlassian.net/browse/PLATFORM-1300) for more information.
