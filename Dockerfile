FROM ruby:3.2

COPY Gemfile Gemfile.lock ./

RUN gem install rails

RUN bundle install

RUN apt-get update && apt-get install -y mariadb-client
