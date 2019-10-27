#!/bin/bash
# This is entrypoint for docker image of viauco sandbox on docker cloud

RAILS_ENV=development cd sandbox && bundle exec rails s -p 3000 -b '0.0.0.0'
