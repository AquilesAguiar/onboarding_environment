defmodule CadProductsPhoenix.ProductIndex do
  import Tirexs.HTTP

  def create_product(prod) do
    product_json = product_json(prod)
    case post("#{get_link()}#{product_json.id}", product_json) do
      {:ok, 201, _} -> {:ok, 201}
      _ -> {:error, 422}
    end
  end

  def update_product(prod) do
    product_json = product_json(prod)
    case put("#{get_link()}#{product_json.id}", product_json) do
      {:ok, 201, _} -> {:ok, 201}
      _ -> {:error, 422}
    end
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

  def delete_product(id) do
    case delete("#{get_link()}#{id}") do
      {:ok, 200, _} -> {:ok, 200}
      _ -> {:error, 422}
    end
  end

  def delete_all_products() do
    link = Application.get_env(:cad_products_phoenix, :elsk_link)[:link]
    delete(link)
  end

  def get_product(id) do
    case get("#{get_link()}#{id}") do
      {:ok, 200, get_product} -> get_product
      _ -> {:error, 422}
    end
  end

  def search_products(params) do
    query = Enum.map_join(params, "%20AND%20", fn {k, v} -> "#{k}:#{v}" end)
    "#{get_link()}#{if query != "", do: "_search?q="}#{query}"
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

  defp get_link() do
    link = Application.get_env(:cad_products_phoenix, :elsk_link)[:link]
    index = Application.get_env(:cad_products_phoenix, :elsk_index)[:index]
    "#{link}#{index}"
  end
end
