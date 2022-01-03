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
    format_json_products(get("/cad_products/products/_search"))
  end

  def search_products(params) do
    keys_params = Map.keys(params)
    Enum.each(keys_params, fn(key) ->
      format_json_products(get("cad_products/products/_search?q=#{key}:#{Map.get(params, key)}*"))
    end)
  end

  def format_json_products(products) do
    {:ok, 200, all_products} = products
    products = all_products.hits.hits

    products = Enum.map(products, fn(product) -> product._source end)

    products
  end

end
