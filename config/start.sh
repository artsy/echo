#!/bin/bash

echo "Running migrations"
bundle exec rake db:migrate
echo "Starting server"
bundle exec puma -C config/puma.rb
