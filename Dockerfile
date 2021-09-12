FROM ruby:3.0.2

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

COPY . /app

RUN bundle install
