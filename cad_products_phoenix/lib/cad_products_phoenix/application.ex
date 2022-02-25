defmodule CadProductsPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  import Supervisor.Spec

  alias CadProductsPhoenix.Services.Cache

  def start(_type, _args) do
    Logger.add_backend(Sentry.LoggerBackend)

    redis_config = Application.get_env(:cad_products_phoenix, :redis_server)

    children = [
      supervisor(CadProductsPhoenix.Repo, []),
      # Start the Telemetry supervisor
      CadProductsPhoenixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CadProductsPhoenix.PubSub},
      # Start the Endpoint (http/https)
      CadProductsPhoenixWeb.Endpoint,
      {Redix, {"redis://localhost:6379/#{redis_config}", [name: Cache.get_conn()]}}
      # Start a worker by calling: CadProductsPhoenix.Worker.start_link(arg)
      # {CadProductsPhoenix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CadProductsPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CadProductsPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
