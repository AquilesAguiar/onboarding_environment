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
    if params == %{} do
      "/cad_products/products/_search"
      |> get()
      |> format_json_products()
    else
      query = Enum.map_join(params, "*&", fn {k, v} -> "#{k}:#{v}" end)

      "cad_products/products/_search?q=#{query}"
      |> get()
      |> format_json_products()
    end
  end

  defp format_json_products(products) do
    case products do
      {:ok, 200, all_products} ->
        products = all_products.hits.hits
        Enum.map products, &(&1._source)
      _ -> {:error, %{code: 422, message:  "Products not found"}}
    end
  end

end
