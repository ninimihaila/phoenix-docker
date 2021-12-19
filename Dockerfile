ARG ELIXIR_VERSION="1.13.1"
ARG NODE_VERSION="17.3.0"
ARG PHOENIX_VERSION="1.6.2"

FROM elixir:${ELIXIR_VERSION}-alpine

# RUN mkdir assets
RUN mkdir /app
WORKDIR /app

# install other OS dependencies
RUN apk add --update \
  alpine-sdk \
  npm \
  bash \
  curl \
  git \
  inotify-tools \
  xvfb \
  chromium \
  chromium-chromedriver

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
RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install --force hex phx_new ${PHOENIX_VERSION}

CMD mix deps.get && mix ecto.create && mix ecto.migrate && cd assets && npm i && cd .. && mix phx.server
