defmodule CadProductsPhoenixWeb.RegisterController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register

  action_fallback CadProductsPhoenixWeb.FallbackController

  def index(conn, _params) do
    register = Management.list_register()
    render(conn, "index.json", register: register)
  end

  def create(conn, %{"register" => register_params} ) do
    with {:ok, %Register{} = register} <- Management.create_register(register_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.register_path(conn, :show, register))
      |> render("show.json", register: register)
    end
  end

  def show(conn, %{"id" => id}) do
    register = Management.get_register!(id)
    render(conn, "show.json", register: register)
  end

  def update(conn, %{"id" => id, "register" => register_params}) do
    register = Management.get_register!(id)

    with {:ok, %Register{} = register} <- Management.update_register(register, register_params) do
      render(conn, "show.json", register: register)
    end
  end

  def delete(conn, %{"id" => id}) do
    register = Management.get_register!(id)

    with {:ok, %Register{}} <- Management.delete_register(register) do
      send_resp(conn, :no_content, "")
    end
  end
end
