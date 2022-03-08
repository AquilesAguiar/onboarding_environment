defmodule MailerService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    spandex_opts = [
      host: System.get_env("DATADOG_HOST") || "localhost",
      port: System.get_env("DATADOG_PORT") || 8126,
      batch_size: System.get_env("SPANDEX_BATCH_SIZE") || 10,
      sync_threshold: System.get_env("SPANDEX_SYNC_THRESHOLD") || 100,
      http: HTTPoison
    ]

    Logger.add_backend(Sentry.LoggerBackend)

    children = [
      {SpandexDatadog.ApiServer, spandex_opts},
      # Start the Telemetry supervisor
      MailerServiceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MailerService.PubSub},
      # Start the Endpoint (http/https)
      MailerServiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MailerService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MailerServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
