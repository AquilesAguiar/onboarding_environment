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
  username: "3c4670bdbfcc87", # or {:system, "SMTP_USERNAME"}
  password: "1901c27259f9a7", # or {:system, "SMTP_PASSWORD"}
  tls: :always, # can be `:always` or `:never`
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"], # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if_available # can be `:always`. If your smtp relay requir

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

if Mix.env() == :test do
  config :mailer_service, MailerService.Mailer, adapter: MailerService.SMTPTestAdapter
end
