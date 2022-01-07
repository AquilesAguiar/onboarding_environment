defmodule CadProductsPhoenix.ProductIndex do
  import Tirexs.HTTP

  def create_product(prod) do
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

  def delete_product(product) do
    delete("/cad_products/products/#{product.id}")
  end

  def search_products(params) do
    query = Enum.map_join(params, "*&", fn {k, v} -> "#{k}:#{v}" end)
    "cad_products/products/_search#{if query != "", do: "?q="}#{query}"
    |> get()
    |> format_json_products()
  end

  defp format_json_products({:ok, 200, all_products}) do
    products = all_products.hits.hits
    products = Enum.map products, &(&1._source)
    {:ok, products}
  end

  defp format_json_products(error) do
    {:error, error}
  end
end
