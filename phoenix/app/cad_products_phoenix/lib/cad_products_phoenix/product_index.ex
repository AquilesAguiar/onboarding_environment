defmodule CadProductsPhoenix.ProductIndex do

  import Tirexs.HTTP

  def index_product({:ok, prod}) do
    product_json =
       %{
        id: prod.id,
        sku: prod.sku,
        name: prod.name,
        price: prod.price,
        qtd: prod.qtd,
        description: prod.description,
        last_update_at: DateTime.to_iso8601(DateTime.utc_now())
      }

    put("/cad_products/products/#{product_json.id}", product_json)
  end

  def delete_index_product(product) do
    delete("/cad_products/products/#{product.id}")
  end

  def search_index_product(_params) do
    get("/my_index/users/1")
  end

end
