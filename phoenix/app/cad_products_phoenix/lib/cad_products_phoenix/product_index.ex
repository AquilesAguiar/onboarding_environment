defmodule CadProductsPhoenix.ProductIndex do

  import Tirexs.HTTP
  alias CadProductsPhoenix.Management

  def index_product(product) do
    {:ok, prod} = product
    IO.inspect(prod)
    product_json =
       %{
        id: prod.id,
        sku: prod.sku,
        name: prod.name,
        price: prod.price,
        qtd: prod.qtd,
        description: prod.description
      }

    put("/cad_products/products/#{product_json.id}", product_json)
  end

  def delete_index_product(product) do
    delete("/cad_products/products/#{product.id}")
  end
end
