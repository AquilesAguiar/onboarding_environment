defmodule CadProductsPhoenixWeb.Router do
  use CadProductsPhoenixWeb, :router
  use Sentry.PlugCapture

  pipeline :api do
    plug :accepts, ["json"]
    plug Sentry.PlugContext
  end

  pipeline :exq do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
    plug ExqUi.RouterPlug, namespace: "exq"
  end

  scope "/", CadProductsPhoenixWeb do
    pipe_through :api
    resources "/registers", RegisterController, only: [:index, :show, :create, :update, :delete]
    resources "/report", ReportController, only: [:index, :create]
  end

  scope "/exq", ExqUi do
    pipe_through :exq
    forward "/", RouterPlug.Router, :index
  end
end
