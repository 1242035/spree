# This dockerfile is used to build sandbox image for docker clouds. It's not meant to be used in projects
FROM ruby:2.5.6
RUN apt-get update -qq && \
  apt-get install -y build-essential libpq-dev && \
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN mkdir /viauco
WORKDIR /viauco
ADD . /viauco
RUN bundle install
RUN bundle exec rake sandbox
CMD ["sh", "docker-entrypoint.sh"]
