#!/usr/bin/env bash
# Exit on error
set -o errexit

chmod +x ./bin/rails

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
