#!/bin/sh

#echo "Migrate DB"
#bundle exec rake db:migrate
#
#echo "Seed DB."
#bundle exec rake db:seed
#
# echo "Start sidekiq"
# bundle exec sidekiq -C config/sidekiq.yml -c $SIDEKIQ_CONCURRENCY -d

echo "Start Puma server"
bundle exec puma -C config/puma.rb
