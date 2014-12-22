FROM seapy/rails-nginx-unicorn-pro:v1.0-ruby2.1.2-nginx1.6.0

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
ADD . /app

EXPOSE 80
