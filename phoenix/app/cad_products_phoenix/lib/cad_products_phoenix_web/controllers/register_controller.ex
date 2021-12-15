defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register

  action_fallback CadProductsPhoenixWeb.FallbackController

  plug :search_product when action in [:show, :update, :delete]

  def index(conn, _params) do
    register = Management.list_register()
    render(conn, "index.json", register: register)
  end

  def create(conn, %{"product" => register_params} ) do
    Management.create_register(register_params)
  end

  def show(conn, _) do
    render(conn, "show.json", register: conn.assigns[:register])
  end

  def update(conn, %{"product" => register_params} ) do
    Management.update_register(conn.assigns[:register], register_params)
  end

  def delete(conn, _) do
    register = conn.assigns[:register]

    with {:ok, %Register{} = register} <- Management.delete_register(register) do
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
      send_resp(conn, :not_found, "Product with #{id} not found")
    end
  end
end
