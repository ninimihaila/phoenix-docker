use Mix.Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :phx_app, PhxApp.Repo,
  username: "postgres",
  password: "postgres",
  database: "phx_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# Since we'll be using Wallaby with Phoenix and Ecto, we need to set up some configuration, so that (a) Phoenix runs a server during tests, and (b) Phoenix and Ecto use Ecto's sandbox for concurrent tests.
config :phx_app, PhxAppWeb.Endpoint,
  http: [port: 4002],
  server: true

# We'll only want to use Ecto's sandbox in tests, so set the following configuration that we'll use in the next step:
config :phx_app, :sql_sandbox, true

# wallaby configurations
config :wallaby,
  screenshot_on_failure: true,
  driver: Wallaby.Chrome

# Print only warnings and errors during test
config :logger, level: :warn
