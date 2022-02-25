defmodule MailerServiceWeb.Router do
  use MailerServiceWeb, :router
  use Sentry.PlugCapture

  pipeline :api do
    plug :accepts, ["json"]
    plug Sentry.PlugContext
  end

  scope "/", MailerServiceWeb do
    pipe_through :api
    post "/send", EmailController, :send
  end
end
