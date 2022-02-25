# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mailer_service, MailerService.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailtrap.io",
  hostname: "smtp.mailtrap.io",
  port: 2525,
  # or {:system, "SMTP_USERNAME"}
  username: "571cc5ce4b9d0f",
  # or {:system, "SMTP_PASSWORD"}
  password: "d21a5dfd93f126",
  # can be `:always` or `:never`
  tls: :always,
  # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  # can be `true`
  ssl: false,
  retries: 1,
  # can be `true`
  no_mx_lookups: false,
  # can be `:always`. If your smtp relay requir
  auth: :if_available

# Configures the endpoint
config :mailer_service, MailerServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G0xm/uh1fP2LxJMizSlrLPu74uPY7WbwTtwWpUFVAOEZDczg1eGUXZTK5PoXN7a5",
  render_errors: [view: MailerServiceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MailerService.PubSub,
  live_view: [signing_salt: "1xY1MDjY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :sentry,
  dsn: "https://c23f291cef024149b86bd5aaf5674209@o1152388.ingest.sentry.io/6232367",
  included_environments: [:prod, :dev],
  environment_name: Mix.env()
