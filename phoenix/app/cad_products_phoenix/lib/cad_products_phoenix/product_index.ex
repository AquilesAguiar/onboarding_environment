defmodule CadProductsPhoenix.ProductIndex do

  import Tirexs.HTTP

  def index_product(prod) do
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

  def get_all_product() do
    get("/cad_products/products/_search")
    |> format_json_products()
  end

  def join_string(var, string) do
    var <> string
  end

  def search_products(params) do
    query = Enum.map(params, fn {k, v} -> "#{k}:#{v}*&" end)
    query = Enum.join(query)
    get("cad_products/products/_search?q=#{query}")
    |> format_json_products()
  end

  def format_json_products(products) do
    {:ok, 200, all_products} = products
    products = all_products.hits.hits
    Enum.map products, &(&1._source)
  end

end
