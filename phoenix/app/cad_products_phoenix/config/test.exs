use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :cad_products_phoenix, CadProductsPhoenix.Repo,
  database: "cad_products_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cad_products_phoenix, CadProductsPhoenixWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
