FROM golang:1.18.1-bullseye@sha256:3b1a72af045ad0fff9fe8e00736baae76d70ff51325ac5bb814fe4754044b972 AS overmind

WORKDIR /app
RUN curl -L https://github.com/DarthSim/overmind/archive/refs/tags/v2.2.2.tar.gz | gunzip - | tar -xv
WORKDIR /app/overmind-2.2.2
RUN go build .

ARG RAILS_ENV=production
FROM ruby:3.1.2-bullseye@sha256:e75f1da5372940f6997c94c9c48db8e4292fb625ca49035fa53e7e5b9124d6fb

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libvips42 \
      libpoppler102 \
      imagemagick \
      ffmpeg \
      tmux \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=overmind /app/overmind-2.2.2/overmind /usr/local/bin/

WORKDIR /app
ENV RAILS_ENV=$RAILS_ENV
ADD Gemfile* .
RUN bundle install
COPY . .
RUN bin/rails assets:precompile

EXPOSE 8080
CMD overmind start

