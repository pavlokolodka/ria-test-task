FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client
  
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /app

COPY . .

RUN mix deps.get

RUN mix compile

RUN chmod +x entrypoint.sh

EXPOSE 4000

CMD ["./entrypoint.sh"]
