use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :cad_products_phoenix, CadProductsPhoenix.Repo,
  database: "cad_products_test",
  hostname: "localhost"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cad_products_phoenix, CadProductsPhoenixWeb.Endpoint,
  http: [port: 4002],
  server: false

config :cad_products_phoenix, redis_server: 1
config :cad_products_phoenix, elsk_link: "/cad_products_test/"
config :cad_products_phoenix, elsk_index: "products/"
config :cad_products_phoenix, csv_folder: "test/cad_products_phoenix_web/reports/"
# Print only warnings and errors during test
config :logger, level: :warn
