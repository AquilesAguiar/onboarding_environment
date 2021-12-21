defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  import Tirexs.HTTP

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register

  action_fallback CadProductsPhoenixWeb.FallbackController

  plug :search_product when action in [:show, :update, :delete]

  def index(conn, _params) do
    case Cache.get_product("products") do
      {:ok, products} ->
        format_json(products)
        render(conn, "index.json", register: products)
      {:not_found, "key not found"} ->
        register = Management.list_register()
        Cache.set_product("products", register)
        render(conn, "index.json", register: register)
      end
  end

  def create(_conn, %{"product" => register_params} ) do
    Cache.delete_product("products")
    Management.create_register(register_params)
  end

  def show(conn, _) do
    render(conn, "show.json", register: conn.assigns[:register])
  end

  def update(conn, %{"product" => register_params} ) do
    Cache.delete_product("products")
    Management.update_register(conn.assigns[:register], register_params)
  end

  def delete(conn, _) do
    register = conn.assigns[:register]
    with {:ok, %Register{}} <- Management.delete_register(register) do
      Cache.delete_product("products")
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

  defp format_json(products) do
    products_json = Enum.map(products, fn(product) ->
       %{
        id: product.id,
        sku: product.sku,
        name: product.name,
        price: product.price,
        qtd: product.qtd,
        description: product.description
      }
    end)

    Enum.each(products_json, fn(product) -> put("/cad_products/products/#{product.id}", product) end)
  end

end
