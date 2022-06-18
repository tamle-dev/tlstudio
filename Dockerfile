FROM ruby:3.0.2-alpine3.13

RUN apk update && \
    apk add build-base postgresql-dev mariadb-dev && \
    apk add git nodejs tzdata ncurses imagemagick file && \
    apk add curl curl-dev libxml2-dev && \
    apk add npm && \
    rm -rf /var/cache/apk/*

RUN npm install --global yarn

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile /app/
COPY ./Gemfile.lock /app/

RUN bundle install

EXPOSE 80
ENV PORT 80

COPY ./ /app
RUN bundle exec rake assets:precompile

CMD ["./docker-entrypoint.sh"]
