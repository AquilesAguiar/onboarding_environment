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

  describe "elasticksearch module test" do

    test "post a new product" do
      assert ProductIndex.create_product(@product) == {:ok, 201}
    end

    test "get a product, if params is valid" do
      ProductIndex.create_product(@product)
      {:ok, 200, get_product} = ProductIndex.get_product(@product.id)
      assert get_product[:_id] == @product.id
    end

    test "delete a product, if id is valid" do
      ProductIndex.create_product(@product)
      assert ProductIndex.delete_product(@product.id) == {:ok, 200}
    end
  end
end
