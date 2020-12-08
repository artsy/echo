# Echo Proxy

[First added here](https://github.com/artsy/echo/pull/59), the Echo proxy is a thin Express app that proxies traffic sent to the `echo-api-production.herokuapp.com` URL. Version 6.7.0 of the app now sends Echo requests to `echo.artsy.net`, a domain we control. Older versions of the app send requests directly to Heroku, so we couldn't remove that app. Also, we couldn't deploy that app because dependencies no longer existed (see [CX-386](https://artsyproduct.atlassian.net/browse/CX-386) for more info).

It's very important that this proxy app continues to run. To deploy new versions, check out the `heroku-proxy-to-s3` branch locally, commit changes, push to GitHub, and deploy to Heroku:

```sh
heroku login
git push heroku +head:master # Pushes whatever branch you're on to Heroku to deploy
```
