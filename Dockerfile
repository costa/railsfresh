FROM rails:latest
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

RUN mkdir /app
WORKDIR /app
ADD . /app
CMD bin/rake db:create db:migrate \
    && rm -f /app/tmp/pids/server.pid \
    && bin/rails s -p 3000 -b '0.0.0.0'
