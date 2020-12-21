FROM elixir:latest

# RUN mkdir assets
RUN mkdir /app
WORKDIR /app

# Install hex package manager and other dependencies
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.7 --force

# install other OS dependencies, like node, npm
RUN apt update && \
  apt install -y \
  nodejs \
  inotify-tools \
  chromium \
  chromium-driver \
  xvfb

RUN curl -L https://npmjs.org/install.sh | sh

RUN chromedriver --version
RUN node --version

# start xvfb automatically
ENV DISPLAY :99
RUN echo '#!/bin/sh\nXvfb :99 -screen 0 1280x1024x24 &\nexec "$@"\n' > /tmp/entrypoint \
  && chmod +x /tmp/entrypoint \
  && mv /tmp/entrypoint /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD mix deps.get && mix ecto.create && mix ecto.migrate && cd assets && npm i && cd .. && mix phx.server
