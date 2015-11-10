#!/usr/bin/env bash

export RACK_ENV=test
rake db:create
rake db:migrate
rake
