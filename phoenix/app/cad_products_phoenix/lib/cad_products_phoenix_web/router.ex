defmodule CadProductsPhoenixWeb.Router do
  use CadProductsPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CadProductsPhoenixWeb do
    pipe_through :api
    resources "/registers", RegisterController, only: [:index, :show, :create, :update, :delete]
  end
end
