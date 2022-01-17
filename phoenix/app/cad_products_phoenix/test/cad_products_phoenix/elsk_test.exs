defmodule CadProductsPhoenix.ElskTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.ProductIndex

  describe "elasticksearch module test" do
    @product %{
      description: "some description",
      name: "some name",
      price: 120.5,
      qtd: 120,
      sku: "78845598",
      barcode: "123456789",
      id: "61e580fc6057a40203db022e",
    }
    @params %{"id" => "61e5b8b26057a7093d59827e"}

    test "post a new product" do
      ProductIndex.create_product(@product)
    end
  end
end
