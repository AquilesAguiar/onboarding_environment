defmodule CadProductsPhoenixWeb.Services.Product do
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.Services.Cache
  alias CadProductsPhoenix.Services.ProductIndex

  def fetch_products(params) do
    case ProductIndex.search_products(params) do
      {:ok, products} ->
        # ProductIndex.delete_all_products()
        {:ok, products}

      {:error, 422} ->
        {:ok, Management.list_register()}
    end
  end

  def create(product) when is_map(product) do
    with {:ok, product} <- Management.create_register(product) do
      Cache.set(product.id, product)
      ProductIndex.create_product(product)
      product
    end
  end

  def update(product, register_params) do
    with {:ok, update_product} <- Management.update_register(product, register_params) do
      Cache.set(product.id, update_product)
      ProductIndex.update_product(update_product)
      update_product
    end
  end

  def delete(product) do
    with {:ok, _} <- Management.delete_register(product) do
      Cache.delete(product.id)
      ProductIndex.delete_product(product.id)
      {:ok, :no_content}
    end
  end
end
