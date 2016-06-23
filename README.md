# echo

[echo](http://github.com/artsy/echo) is a Grape + Rack ([Gris](http://github.com/artsy/gris)) hypermedia API service that provides remote configuration for Artsy mobile clients.

[![Build Status](https://semaphoreci.com/api/v1/projects/0b1b6ac6-4ee1-47b4-a65e-90bc37b414c2/469563/badge.svg)](https://semaphoreci.com/artsy-it/echo)

Meta
---

* __State:__ production
* __Production:__ [https://echo-api-production.herokuapp.com/](https://echo-api-production.herokuapp.com/) | [Web Interface](https://echo-web-production.herokuapp.com) | [Heroku](https://dashboard.heroku.com/apps/echo-api-production/resources)
* __Staging:__ [https://echo-api-staging.herokuapp.com/](https://echo-api-staging.herokuapp.com/) | [Web Interface](https://echo-web-staging.herokuapp.com) | [Heroku](https://dashboard.heroku.com/apps/echo-api-staging/resources)
* __Github:__ [https://github.com/artsy/echo/](https://github.com/artsy/echo/)
* __CI:__ [Semaphore](https://semaphoreci.com/artsy-it/echo/); merged PRs to artsy/echo#master are automatically deployed to staging; production is manually deployed from Semaphore
* __Point People:__ [@dylanfareed](https://github.com/dylanfareed); [@orta](https://github.com/orta)

Set-Up for Development
---
- Fork [artsy/echo](https://github.com/artsy/echo)
- Clone your fork locally; for example:
```
git clone git@github.com:artsy/echo.git
```
- Bundle
```
cd echo
bundle
```
- Set up the database
```
RACK_ENV=test bundle exec rake db:create
RACK_ENV=test bundle exec rake db:migrate
```
- Verify that [Rubocop](https://github.com/bbatsov/rubocop) and specs pass.
```
RACK_ENV=test bundle exec rake
```
