defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register
  alias CadProductsPhoenix.ProductIndex

  action_fallback CadProductsPhoenixWeb.FallbackController

  plug :search_product when action in [:show, :update, :delete]

  def index(conn, _params) do
    IO.inspect(Cache.get("products"))
    case Cache.get("products") do
      {:ok, products} ->
        ProductIndex.index_products()
        render(conn, "index.json", register: products)
      {:error, "key not found"} ->
        register = Management.list_register()
        Cache.set("products", register)
        render(conn, "index.json", register: register)
      end
  end

  def create(conn, %{"product" => register_params} ) do
    case Management.create_register(register_params) do
      {:ok, product} ->
        Cache.delete("products")
        ProductIndex.index_products()
        render(conn, "show.json", register: product)
      error -> error
    end
  end

  def show(conn, _) do
    render(conn, "show.json", register: conn.assigns[:register])
  end

  def update(conn, %{"product" => register_params} ) do
    case Management.update_register(conn.assigns[:register], register_params) do
      {:ok, product} ->
        Cache.delete("products")
        ProductIndex.index_products()
        render(conn, "show.json", register: product)
      error -> error
    end
  end

  def delete(conn, _) do
    register = conn.assigns[:register]
    with {:ok, %Register{}} <- Management.delete_register(register) do
      Cache.delete("products")
      ProductIndex.index_products()
      send_resp(conn, :no_content, "")
    end
  end

  # Plug for get products
  defp search_product(conn, _) do
    id = conn.params["id"]
    register = Management.get_register(id)
    if register do
      assign(conn, :register, register)
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "Product with #{id} not found"})
      |> halt()
    end
  end

end
