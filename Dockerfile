FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  curl

# Install Node.js 22.7.0
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
  && apt-get install -y nodejs

# Install yarn
RUN npm install --global yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle config set force_ruby_platform true && bundle install

COPY package.json ./

RUN yarn install

COPY . .

ENV RAILS_ENV=development
ENV NODE_ENV=development

RUN yarn build

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]