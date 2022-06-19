#!/bin/sh

echo "Migrate DB"
bundle exec rake db:migrate

echo "Seed DB."
bundle exec rake db:seed

echo "Start Puma server"
bundle exec puma -C config/puma.rb