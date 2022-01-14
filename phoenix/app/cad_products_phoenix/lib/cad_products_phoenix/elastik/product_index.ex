defmodule CadProductsPhoenix.Elastik.ProductIndex do
  import Tirexs.HTTP

  def create_product(prod) do
    product_json = product_json(prod)
    post("/cad_products/products/#{product_json.id}", product_json)
  end

  def update_product(prod) do
    product_json = product_json(prod)
    put("/cad_products/products/#{product_json.id}", product_json)
  end

  defp product_json(prod) do
    product_json =
        %{
          id: prod.id,
          sku: prod.sku,
          name: prod.name,
          price: prod.price,
          qtd: prod.qtd,
          description: prod.description,
          barcode: prod.barcode,
          last_update_at: DateTime.to_iso8601(DateTime.utc_now())
        }
    product_json
  end

  def delete_product(id) do
    delete("/cad_products/products/#{id}")
  end

  def search_products(params) do
    query = Enum.map_join(params, "*&", fn {k, v} -> "#{k}:#{v}%20AND%20" end)
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
