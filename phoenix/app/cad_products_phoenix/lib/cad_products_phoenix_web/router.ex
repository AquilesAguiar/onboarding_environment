defmodule CadProductsPhoenixWeb.Router do
  use CadProductsPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CadProductsPhoenixWeb do
    pipe_through :api

    resources "/register", RegisterController
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: CadProductsPhoenixWeb.Telemetry
    end
  end
end
