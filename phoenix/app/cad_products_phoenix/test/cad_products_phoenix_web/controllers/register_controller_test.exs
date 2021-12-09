defmodule CadProductsPhoenixWeb.RegisterControllerTest do
  use CadProductsPhoenixWeb.ConnCase

  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register

  @create_attrs %{
    description: "some description",
    name: "some name",
    price: 120.5,
    qtd: 120.5,
    sku: "some sku"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    price: 456.7,
    qtd: 456.7,
    sku: "some updated sku"
  }
  @invalid_attrs %{description: nil, name: nil, price: nil, qtd: nil, sku: nil}

  def fixture(:register) do
    {:ok, register} = Management.create_register(@create_attrs)
    register
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all register", %{conn: conn} do
      conn = get(conn, Routes.register_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create register" do
    test "renders register when data is valid", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), register: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.register_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name",
               "price" => 120.5,
               "qtd" => 120,
               "sku" => "some sku"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), register: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update register" do
    setup [:create_register]

    test "renders register when data is valid", %{conn: conn, register: %Register{id: id} = register} do
      conn = put(conn, Routes.register_path(conn, :update, register), register: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.register_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name",
               "price" => 456.7,
               "qtd" => 456,
               "sku" => "some updated sku"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, register: register} do
      conn = put(conn, Routes.register_path(conn, :update, register), register: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete register" do
    setup [:create_register]

    test "deletes chosen register", %{conn: conn, register: register} do
      conn = delete(conn, Routes.register_path(conn, :delete, register))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.register_path(conn, :show, register))
      end
    end
  end

  defp create_register(_) do
    register = fixture(:register)
    %{register: register}
  end
end
