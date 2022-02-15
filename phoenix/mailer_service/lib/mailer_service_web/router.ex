defmodule MailerServiceWeb.Router do
  use MailerServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MailerServiceWeb do
    pipe_through :api
    post "/send", EmailController, :send
  end
end
