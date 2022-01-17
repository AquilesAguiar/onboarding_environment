defmodule CadProductsPhoenixWeb.Services.Product do
  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.ProductIndex
  alias CadProductsPhoenix.Management

  def fetch_products(params) do
    case ProductIndex.search_products(params) do
      {:ok, products} -> {:ok, products}
      {:error, _} -> {:ok, Management.list_register()}
    end
  end

  def create(product) when is_map(product) do
    case Management.create_register(product) do
      {:ok, product} ->
        Cache.set(product.id, product)
        ProductIndex.create_product(product)
        product
      error -> error
    end
  end

  def update(product, register_params) do
    case Management.update_register(product, register_params) do
      {:ok, update_product} ->
        Cache.set(product.id, update_product)
        ProductIndex.update_product(update_product)
        update_product
      error -> error
    end
  end

  def delete(product) do
    case Management.delete_register(product) do
      {:ok, _} ->
        Cache.delete(product.id)
        ProductIndex.delete_product(product.id)
        {:ok, :no_content}
      error -> error
    end
  end
end
