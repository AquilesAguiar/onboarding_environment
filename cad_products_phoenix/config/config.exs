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
  metadata: [:request_id, :trace_id, :span_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :cad_products_phoenix, mailer_link: "http://localhost:4444/send"
config :cad_products_phoenix, report_link: "http://localhost:4000/report/"
config :cad_products_phoenix, redis_server: 0
config :cad_products_phoenix, elsk_link: "/cad_products/"
config :cad_products_phoenix, elsk_index: "products/"
config :cad_products_phoenix, csv_folder: "lib/cad_products_phoenix_web/reports/"

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

config :sentry,
  dsn: "https://5f0a1a30a8284bd392da0aae83d10196@o1152388.ingest.sentry.io/6232354",
  included_environments: [:prod, :dev],
  environment_name: Mix.env()

config :cad_products_phoenix, CadProductsPhoenix.Services.Tracer,
  service: :cad_products_phoenix,
  adapter: SpandexDatadog.Adapter

config :spandex, :decorators, tracer: CadProductsPhoenix.Services.Tracer
config :spandex_phoenix, tracer: CadProductsPhoenix.Services.Tracer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
