defmodule CadProductsPhoenix.ProductIndex do
  import Tirexs.HTTP

  def create_product(prod) do
    product_json = product_json(prod)

    case post("#{get_link()}#{get_index()}#{product_json.id}", product_json) do
      {:ok, 201, _} -> {:ok, 201}
      _ -> {:error, 500}
    end
  end

  def update_product(prod) do
    product_json = product_json(prod)

    case put("#{get_link()}#{get_index()}#{product_json.id}", product_json) do
      {:ok, 201, _} -> {:ok, 201}
      _ -> {:error, 500}
    end
  end

  def delete_product(id) do
    case delete("#{get_link()}#{get_index()}#{id}") do
      {:ok, 200, _} -> {:ok, 204}
      _ -> {:error, 422}
    end
  end

  def delete_all_products(), do: delete(get_link())

  def get_product(id) do
    case get("#{get_link()}#{get_index()}#{id}") do
      {:ok, 200, get_product} -> get_product
      _ -> {:error, 422}
    end
  end

  def search_products(params) do
    query = Enum.map_join(params, "%20AND%20", fn {k, v} -> "#{k}:#{v}" end)

    "#{get_link()}#{get_index()}_search#{if query != "", do: "?q="}#{query}"
    |> get()
    |> format_json_products()
  end

  defp product_json(prod) do
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
  end

  defp format_json_products({:ok, 200, all_products}) do
    products = all_products.hits.hits
    products = Enum.map(products, & &1._source)
    {:ok, products}
  end

  defp format_json_products(_error) do
    {:error, 422}
  end

  defp get_link(), do: Application.get_env(:cad_products_phoenix, :elsk_link)[:link]
  defp get_index(), do: Application.get_env(:cad_products_phoenix, :elsk_index)[:index]
end
