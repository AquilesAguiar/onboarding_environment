defmodule CadProductsPhoenixWeb.RegisterControllerTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock

  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register
  alias CadProductsPhoenix.ProductIndex

  @create_attrs %{
    description: "some description",
    name: "some name",
    price: 120.5,
    qtd: 120,
    sku: "45885",
    barcode: "123456789"
  }

  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    price: 456.7,
    qtd: 456,
    sku: "787897",
    barcode: "123456789"
  }
  @invalid_attrs %{description: nil, name: nil, price: nil, qtd: nil, sku: nil, barcode: nil}

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
      assert %{"products" => products} = json_response(conn, 200)
    end
  end

  describe "create register" do
    test "renders register when data is valid", %{conn: conn} do
      conn = post conn, Routes.register_path(conn, :create), product: @create_attrs
      assert %{"id" => id} = json_response(conn, 200)["product"]
      assert Management.get_register(id) != nil
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update register" do
    setup [:create_register]

    test "renders register when data is valid", %{
      conn: conn,
      register: %Register{id: _id} = register
    } do
      conn = put(conn, Routes.register_path(conn, :update, register), product: @update_attrs)

      assert %{"id" => id} = json_response(conn, 200)["product"]

      assert Management.get_register(id) != nil
    end

    test "renders errors when data is invalid", %{conn: conn, register: register} do
      conn = put(conn, Routes.register_path(conn, :update, register), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete register" do
    setup [:create_register]

    test "deletes chosen register", %{conn: conn, register: register} do
      conn = delete(conn, Routes.register_path(conn, :delete, register))
      assert response(conn, 204)
      assert Management.get_register(register.id) == nil
    end
  end

  defp create_register(_) do
    register = fixture(:register)
    %{register: register}
  end
end
