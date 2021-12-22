defmodule CadProductsPhoenix.ProductIndex do

  import Tirexs.HTTP
  alias CadProductsPhoenix.Management

  def index_products() do
    products = Management.list_register()

    products_json = Enum.map(products, fn(product) ->
       %{
        id: product.id,
        sku: product.sku,
        name: product.name,
        price: product.price,
        qtd: product.qtd,
        description: product.description
      }
    end)

    Enum.each(products_json, fn(product) -> put("/cad_products/products/#{product.id}", product) end)
  end

end
