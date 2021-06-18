FROM ruby:2.6

LABEL maintainer=meel.tomlinson@gmail.com

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
 apt-transport-https

# Ensures up to date version of Node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# Ensure lates packages of yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app

RUN export BUNDLE_PATH=/gems

RUN bundle install

COPY . /usr/src/app/

# RUN rails webpacker:install

CMD ["bin/rails", "s", "-b", "0.0.0.0"] 
