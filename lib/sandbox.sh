#!/bin/sh
# Used in the sandbox rake task in Rakefile

set -e

case "$DB" in
postgres)
  RAILSDB="postgresql"
  ;;
mysql)
  RAILSDB="mysql"
  ;;
sqlite|'')
  RAILSDB="sqlite3"
  ;;
*)
  echo "Invalid DB specified: $DB"
  exit 1
  ;;
esac

rm -rf ./sandbox
bundle exec rails new sandbox --database="$RAILSDB" \
  --skip-bundle \
  --skip-git \
  --skip-keeps \
  --skip-rc \
  --skip-spring \
  --skip-test \
  --skip-coffee \
  --skip-javascript \
  --skip-bootsnap

if [ ! -d "sandbox" ]; then
  echo 'sandbox rails application failed'
  exit 1
fi

cd ./sandbox

if [ "$VIAUCO_AUTH_DEVISE_PATH" != "" ]; then
  VIAUCO_AUTH_DEVISE_GEM="gem 'viauco_auth_devise', path: '$VIAUCO_AUTH_DEVISE_PATH'"
else
  VIAUCO_AUTH_DEVISE_GEM="gem 'viauco_auth_devise', github: 'viauco/viauco_auth_devise', branch: 'master'"
fi

if [ "$VIAUCO_GATEWAY_PATH" != "" ]; then
  VIAUCO_GATEWAY_GEM="gem 'viauco_gateway', path: '$VIAUCO_GATEWAY_PATH'"
else
  VIAUCO_GATEWAY_GEM="gem 'viauco_gateway', github: 'viauco/viauco_gateway', branch: 'master'"
fi

cat <<RUBY >> Gemfile
gem 'viauco', path: '..'
$VIAUCO_AUTH_DEVISE_GEM
$VIAUCO_GATEWAY_GEM

group :test, :development do
  gem 'bullet'
  gem 'pry-byebug'
  gem 'rack-mini-profiler'
  gem 'awesome_print'
end
RUBY

bundle install --gemfile Gemfile
bundle exec rails db:drop || true
bundle exec rails db:create
bundle exec rails g viauco:install --auto-accept --user_class=Viauco::User --enforce_available_locales=true --copy_views=false
bundle exec rails g viauco:auth:install
bundle exec rails g viauco_gateway:install
