ARG ELIXIR_VERSION="1.13.1"
FROM elixir:${ELIXIR_VERSION}-alpine

# RUN mkdir assets
RUN mkdir /app
WORKDIR /app

# install other OS dependencies
RUN apk add --update \
  curl \
  zsh \
  git \
  inotify-tools \
  xvfb \
  chromium \
  chromium-chromedriver

RUN apk add --update \
  npm \
  bash

# install Node
ARG NODE_VERSION="latest"

RUN chromedriver --version
RUN node --version

# setup virtual display for running tests in chromedriver
# start xvfb automatically
ENV DISPLAY :99
RUN echo '#!/bin/bash' >> /docker-entrypoint.sh \
  && echo 'Xvfb :99 -screen 0 1280x1024x24 &' >> /docker-entrypoint.sh \
  && echo 'exec "$@"' >> /docker-entrypoint.sh \
  && chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

# cleanup
RUN rm -rf /var/cache/apk/*

# install phoenix
ARG PHOENIX_VERSION="1.6.2"
RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install --force hex phx_new ${PHOENIX_VERSION}

CMD mix deps.get && mix ecto.create && mix ecto.migrate && cd assets && npm i && cd .. && mix phx.server
