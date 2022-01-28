# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cad_products_phoenix,
  ecto_repos: [CadProductsPhoenix.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :cad_products_phoenix, CadProductsPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1qBXEVzMMNM9aMk35SeF6uzeisvEs0OrswR74hWlgX9oBbz0rv2dj1YaRJnuIk1N",
  render_errors: [view: CadProductsPhoenixWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CadProductsPhoenix.PubSub,
  live_view: [signing_salt: "CoFtFDVF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cad_products_phoenix, :redis_server, index: 0
config :cad_products_phoenix, :elsk_link, link: "/cad_products/"
config :cad_products_phoenix, :elsk_index, index: "products/"

config :exq,
  name: Exq,
  host: "127.0.0.1",
  port: 6379,
  namespace: "exq",
  concurrency: :infinite,
  queues: ["report"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 25,
  mode: :default,
  shutdown_timeout: 5000

config :exq_ui,
  server: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
