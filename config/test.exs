use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hearthleague, HearthleagueWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :hearthleague, Hearthleague.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "hearthleague_test",
  password: "hearthleague_test",
  database: "hearthleague_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
