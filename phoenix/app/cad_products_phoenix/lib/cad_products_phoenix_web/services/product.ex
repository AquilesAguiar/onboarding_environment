defmodule CadProductsPhoenixWeb.Services.Product do

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.ProductIndex

  def fetch_all() do
    case Cache.get("products") do
      {:ok, _} = result ->
        ProductIndex.index_products()
        result
      _ ->
        register = Management.list_register()
        Cache.set("products", register)
        register
      end
  end

  def create(%{"product" => product}) when is_map(product) do
    case Management.create_register(product) do
      {:ok, _} = result ->
        Cache.delete("products")
        ProductIndex.index_products()
        result
    end
  end

  def create(_params), do: {:error, 422}

  def update(products, %{"product" => register_params} ) do
    case Management.update_register(products, register_params) do
      {:ok, product} ->
        Cache.delete("products")
        ProductIndex.index_products()
        {:ok, product}
    end
  end

  def update(_products, _params), do: {:error, 422}

  def delete(products) do
    Management.delete_register(products)
    Cache.delete("products")
    ProductIndex.index_products()
  end

  def delete(_products), do: {:error, 422}
end
