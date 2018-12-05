FROM bitwalker/alpine-elixir:1.6.6

RUN apk update
RUN apk add --virtual \
  build-dependencies \
  build-base

RUN apk add \
  "bash" \
  "nodejs" \
  "npm" \
  "inotify-tools" \
  "openssl"

EXPOSE 4000
ENV PORT=4000

# Copy code to install deps
# lib,config,test,assets(some) folders are mounted for development
COPY ./ /code
WORKDIR /code

# Install dependencies to the container
RUN make elixir-install
# package.json is copied, and node modules can install in the container
# Make sure there is no node_modules in the host's folder (or it will be copied with wrong arch)
RUN make node-install

CMD /bin/bash
