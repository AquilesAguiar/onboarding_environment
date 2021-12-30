defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenixWeb.Services.Product

  action_fallback CadProductsPhoenixWeb.FallbackController

  def index(conn, _params) do
    case Product.fetch_all() do
      {:ok, products} -> render(conn, "index.json", register: products)
      error -> error
    end
  end

  def create(_conn, params) do
    Product.create(params)
  end

  def show(conn, _) do
    Product.show(conn.params["id"])
  end

  def update(conn, params) do
    Product.update(conn.params["id"], params)
  end

  def delete(conn, _) do
    Product.delete(conn.params["id"])
    {:ok, :no_content}
  end
end
