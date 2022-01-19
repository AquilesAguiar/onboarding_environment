defmodule CadProductsPhoenix.ElskTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.ProductIndex

  setup do
    ProductIndex.delete_all_products()
    :ok
  end

  @product %{
    description: "some description",
    name: "some name",
    price: 120.5,
    qtd: 120,
    sku: "78845598",
    barcode: "123456789",
    id: "61e580fc6057a40203db022e",
  }
  @invalid_key "25l580gc6057a40203db0220"

  describe "elasticksearch module test" do

    test "post a new product" do
      assert ProductIndex.create_product(@product) == {:ok, 201}
    end

    test "get a product, if id is valid" do
      ProductIndex.create_product(@product)
      get_product = ProductIndex.get_product(@product.id)
      assert get_product[:_id] == @product.id
    end

    test "get a product, id is invalid" do
      get_product = ProductIndex.get_product(@product.id)
      assert get_product == {:error, 422}
    end

    test "delete a product, if id is valid" do
      ProductIndex.create_product(@product)
      assert ProductIndex.delete_product(@product.id) == {:ok, 200}
    end

    test "delete a product, id is invalid" do
      assert ProductIndex.delete_product(@invalid_key) == {:error, 422}
    end
  end
end
