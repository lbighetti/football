FROM elixir:1.8.1 as builder

RUN apt-get -qq update
RUN apt-get -qq install build-essential

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV prod
WORKDIR /app
ADD . .

RUN mix deps.get
RUN mix release --env=$MIX_ENV


# -------
# Next step is to build the container with the release only.
#
# The strategy is to prepare the container to run the server
# and copy the release from the builder container (above) to the
# release container and run it.
# -------

FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y locales curl jq

# Set LOCALE to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /app
COPY --from=builder /app/_build/prod/rel/football .

ENV DATABASE_HOSTNAME host.docker.internal
ENV DATABASE_USERNAME=postgres
ENV DATABASE_PASSWORD=postgres
ENV DATABASE=football_prod
ENV HOST localhost
ENV PORT 4000

RUN /app/bin/football migrate
CMD ["/app/bin/football", "foreground"]
