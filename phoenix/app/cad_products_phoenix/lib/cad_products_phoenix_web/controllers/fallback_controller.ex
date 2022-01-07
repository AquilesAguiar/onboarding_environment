defmodule CadProductsPhoenixWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Management.Register

  def call(conn, %Register{} = register) do
    render(conn, "show.json", register: register)
  end

  def call(conn, register) do
    render(conn, "index.json", register: register)
  end

  def call(conn, {:ok, :no_content}) do
    send_resp(conn, :no_content, "")
  end

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(CadProductsPhoenixWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(CadProductsPhoenixWeb.ErrorView)
    |> render(404)
  end

  def call(conn, {:error, %{code: error_code, message: message}}) when is_number(error_code) do
    conn
    |> put_status(error_code)
    |> put_view(CadProductsPhoenixWeb.ErrorView)
    |> send_resp(error_code, message)
  end
end
