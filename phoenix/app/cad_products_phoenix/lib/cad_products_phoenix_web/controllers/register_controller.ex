defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register

  action_fallback CadProductsPhoenixWeb.FallbackController

  def index(conn, _params) do
    register = Management.list_register()
    render(conn, "index.json", register: register)
  end

  def create(conn, %{"product" => register_params} ) do
    case Management.create_register(register_params) do
      {:ok, %Register{} = register} -> render(conn, "show.json", register: register)
      _ -> render(conn, "show.json", %{error: "Failed to create a product"})
    end
  end

  def show(conn, %{"id" => id}) do
    register = Management.get_register!(id)
    render(conn, "show.json", register: register)
  end

  def update(conn, %{"id" => id, "product" => register_params}) do
    register = Management.get_register!(id)

    if register do

      case Management.update_register(register, register_params) do
        {:ok, %Register{} = register} -> render(conn, "show.json", register: register)
        _ -> render(conn, "show.json", %{error: "Failed to update a product #{id}"})
      end

    else

      json(conn, %{error: "Product with #{id} not found"})

    end

  end

  def delete(conn, %{"id" => id}) do
    register = Management.get_register!(id)
    if register do
      case Management.delete_register(register) do
        {:ok, %Register{}} -> send_resp(conn, :no_content, "")
        _ -> render(conn, "show.json", %{error: "Failed to delete a product #{id}"})
         end
    else

      json(conn, %{error: "Product with #{id} not found"})

    end
  end
end
