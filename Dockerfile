from ubuntu:latest

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_CTYPE="en_US.UTF-8"
ENV PORT=80

ENV POSTGRES_HOST=postgres

RUN apt-get update && apt-get install -y curl wget sudo make \
  && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && sudo dpkg -i erlang-solutions_1.0_all.deb \
  && sudo apt-get update \
  && sudo apt-get install -y esl-erlang elixir \
  && curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - \
  && sudo apt-get install -y nodejs build-essential

EXPOSE 80

WORKDIR /hearthleague

ADD . /hearthleague

RUN mkdir /var/hearthleague \ 
  && mix local.hex --force \
  && mix local.rebar \
  && mix deps.get --force --only prod \
  && mix compile \
  && npm install --prefix assets \
  && node assets/node_modules/brunch/bin/brunch build assets \ 
  && mix phx.digest
