defmodule CadProductsPhoenixWeb.RegisterControllerTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock

  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Management.Register
  alias CadProductsPhoenix.Services.ProductIndex

  @create_attrs %{
    description: "some description",
    name: "some name",
    price: 120.5,
    qtd: 120,
    sku: "12345",
    barcode: "123456789"
  }

  @product_els %{
    description: "test",
    name: "some name",
    price: 120.5,
    qtd: 120,
    sku: "78845598",
    barcode: "123456789",
    id: "61e580fc6057a40203db022e"
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

    fixture_attrs = %{@create_attrs | sku: "#{Enum.random(0..6999)}"}

    {:ok, register} = Management.create_register(fixture_attrs)
    register
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all register", %{conn: conn} do
      with_mock Tirexs.HTTP,
        get: fn
          _param -> {:ok, 200, %{hits: %{hits: [%{_source: @product_els}]}}}
        end do
        conn = get(conn, Routes.register_path(conn, :index))

        assert %{"products" => [atom_to_string(@product_els)]} == json_response(conn, 200)

        assert_called(Tirexs.HTTP.get("/cad_products_test/products/_search"))
      end
    end

    test "search a register", %{conn: conn} do
      with_mock ProductIndex,
        search_products: fn
          %{"id" => "61e580fc6057a40203db022e"} -> {:ok, [@product_els]}
        end do
        conn = get(conn, Routes.register_path(conn, :index), id: "61e580fc6057a40203db022e")

        assert %{"products" => [atom_to_string(@product_els)]} == json_response(conn, 200)

        assert_called(ProductIndex.search_products(%{"id" => "61e580fc6057a40203db022e"}))
      end
    end
  end

  describe "create register" do
    test "renders register when data is valid", %{conn: conn} do
      with_mock ProductIndex,
        create_product: fn
          _params -> {:ok, 201}
        end do
        conn = post(conn, Routes.register_path(conn, :create), product: @create_attrs)

        assert %{"id" => id} = json_response(conn, 200)["product"]

        assert Management.get_register(id) != nil

        assert_called(ProductIndex.create_product(@create_attrs))
      end
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), product: @create_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors when sku is not unique", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), product: @create_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update register" do
    setup [:create_register]

    test "renders register when data is valid", %{
      conn: conn,
      register: %Register{id: _id} = register
    } do
      with_mock ProductIndex,
        update_product: fn
          _upd_prod -> {:ok, 201}
        end do
        conn = put(conn, Routes.register_path(conn, :update, register), product: @update_attrs)

        assert %{"id" => id} = json_response(conn, 200)["product"]

        assert Management.get_register(id) != nil

        assert_called(ProductIndex.update_product(@update_attrs))
      end
    end

    test "renders errors when data is invalid", %{conn: conn, register: register} do
      conn = put(conn, Routes.register_path(conn, :update, register), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete register" do
    setup [:create_register]

    test "deletes chosen register", %{conn: conn, register: register} do
      with_mock ProductIndex,
        delete_product: fn
          _id -> {:ok, 201}
        end do
        conn
        |> delete(Routes.register_path(conn, :delete, register))
        |> response(204)

        assert_called(ProductIndex.delete_product(register.id))

        assert Management.get_register(register.id) == nil
      end
    end
  end

  defp create_register(_) do
    register = fixture(:register)
    %{register: register}
  end

  defp atom_to_string(map) do
    Map.new(map, fn {k, v} -> {Atom.to_string(k), v} end)
  end
end
