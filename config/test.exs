use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :liveman, Liveman.Repo,
  username: "postgres",
  password: "postgres",
  database: "liveman_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :liveman, LivemanWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configurations for ExVCR
config :exvcr,
  vcr_cassette_library_dir: "test/support/fixtures/vcr_cassettes"
