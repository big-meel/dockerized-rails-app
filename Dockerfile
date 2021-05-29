FROM ruby:2.6

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
 nodejs \
 npm -y \
 && npm install --global yarn

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app
RUN bundle install
RUN rails webpacker:install

COPY . /usr/src/app/

CMD ["rails", "s", "-b", "0.0.0.0"] 
