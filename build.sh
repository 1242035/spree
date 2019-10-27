#!/bin/sh

set -e

# Switching Gemfile
set_gemfile(){
  echo "Switching Gemfile..."
  export BUNDLE_GEMFILE="`pwd`/Gemfile"
}

prepare_app(){
  set_gemfile
  bundle update --quiet
  echo "Preparing test app..."
  BUNDLE_GEMFILE=../Gemfile bundle exec rake test_app
}
# Target postgres. Override with: `DB=sqlite bash build.sh`
export DB=${DB:-postgres}

# Viauco defaults
echo "Setup Viauco defaults..."
bundle check || bundle update --quiet

# Viauco API
echo "**************************************"
echo "* Setup Viauco API and running RSpec..."
echo "**************************************"
cd api; prepare_app; bundle exec rspec spec

# Viauco Backend
echo "******************************************"
echo "* Setup Viauco Backend and running RSpec..."
echo "******************************************"
cd ../backend; prepare_app; bundle exec rspec spec

# Viauco Core
echo "***************************************"
echo "* Setup Viauco Core and running RSpec..."
echo "***************************************"
cd ../core; prepare_app; bundle exec rspec spec

# Viauco Frontend
echo "*******************************************"
echo "* Setup Viauco Frontend and running RSpec..."
echo "*******************************************"
cd ../frontend; prepare_app; bundle exec rspec spec

# Viauco Sample
echo "*****************************************"
echo "* Setup Viauco Sample and running RSpec..."
echo "*****************************************"
cd ../sample; prepare_app; bundle exec rspec spec

