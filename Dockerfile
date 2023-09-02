FROM ruby:3.2

COPY Gemfile Gemfile.lock ./

RUN gem install rails

RUN bundle install
