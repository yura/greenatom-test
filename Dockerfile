FROM ruby:3.2.2

ADD . /app
WORKDIR /app
RUN bundle i

ENTRYPOINT rails db:create db:migrate && rails server -b 0.0.0.0
