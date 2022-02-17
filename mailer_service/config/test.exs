use Mix.Config

if Mix.env() == :test do
  config :mailer_service, MailerService.Mailer, adapter: MailerService.SMTPTestAdapter
end

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# config :mailer_service, MailerService.Repo,
#   username: "postgres",
#   password: "postgres",
#   database: "mailer_service_test#{System.get_env("MIX_TEST_PARTITION")}",
#   hostname: "localhost",
#   pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mailer_service, MailerServiceWeb.Endpoint,
  http: [port: 4442],
  server: false

config :mailer_service, MailerService.Mailer, adapter: Bamboo.TestAdapter

# Print only warnings and errors during test
config :logger, level: :warn
