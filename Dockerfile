FROM ruby:2.6

LABEL maintainer=meel.tomlinson@gmail.com

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
 nodejs \
 npm -y \
 && npm install --global yarn

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

RUN rails webpacker:install

CMD ["rails", "s", "-b", "0.0.0.0"] 
