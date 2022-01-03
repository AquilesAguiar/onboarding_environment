defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenixWeb.Services.Product


  action_fallback CadProductsPhoenixWeb.FallbackController

  plug :get_cache when action in [:show, :update, :delete]

  def index(conn, _params) do
    case Product.fetch_all(conn) do
      {:ok, products} -> render(conn, "index.json", register: products)
      error -> error
    end
  end

  def create(_conn, params) do
    Product.create(params)
  end

  def show(conn, _) do
    Product.show(conn.assigns[:register])
  end

  def update(conn, params) do
    Product.update(conn.assigns[:register], params)
  end

  def delete(conn, _) do
    Product.delete(conn.assigns[:register])
    {:ok, :no_content}
  end

  defp get_cache(conn, _) do
    id = conn.params["id"]
    case Cache.get(id) do
      {:ok, _} = result ->
        assign(conn, :register, result)
      _ ->
        register = Management.get_register(id)
        if register do
          Cache.set(id, register)
          assign(conn, :register, {:ok, register})
        else
          conn
          |> put_status(:not_found)
          |> json(%{error: "Product with #{id} not found"})
          |> halt()
        end
    end
  end
end
