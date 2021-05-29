FROM ruby:2.6

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
 nodejs \
 npm -y \
 && npm install --global yarn

COPY . /usr/src/app/

WORKDIR /usr/src/app
RUN bundle install
RUN rails webpacker:install

CMD ["rails", "s", "-b", "0.0.0.0"] 
