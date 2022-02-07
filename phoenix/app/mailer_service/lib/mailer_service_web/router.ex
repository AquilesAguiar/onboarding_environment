defmodule MailerServiceWeb.Router do
  use MailerServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MailerServiceWeb do
    pipe_through :api
  end

end
