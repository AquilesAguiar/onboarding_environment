defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register
  alias CadProductsPhoenixWeb.Services.Product

  action_fallback CadProductsPhoenixWeb.FallbackController

  plug :get_cache when action in [:show, :update, :delete]
  plug :return_product when action in [:create, :update]

  def index(conn, _params) do
    case Product.fetch_products(conn.params) do
      {:ok, products} -> render(conn, "index.json", register: products)
      error -> error
    end
  end

  def create(conn, _) do
    Product.create(conn.assigns[:product_params])
  end

  def show(conn, _) do
    conn.assigns[:register]
  end

  def update(conn, _) do
    Product.update(conn.assigns[:register], conn.assigns[:product_params])
  end

  def delete(conn, _) do
    Product.delete(conn.assigns[:register])
  end

  defp get_cache(conn, _) do
    id = conn.params["id"]
    case Cache.get(id) do
      {:ok, product} ->
        assign(conn, :register, product)
      _ ->
        case Management.get_register(id) do
          %Register{} = register ->
            Cache.set(id, register)
            assign(conn, :register, register)
          _ ->
            conn
            |> put_status(:not_found)
            |> json(%{error: "Product with #{id} not found"})
            |> halt()
        end
    end
  end

  defp return_product(conn, _) do
    case conn.body_params do
      %{"product" => product_params} -> assign(conn, :product_params, product_params)
      _ ->
        conn
        |> put_status(422)
        |> json(%{error: "Unable to find the product, check if it exists or if you are passing the json correctly"})
        |> halt()
    end
  end
end
