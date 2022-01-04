defmodule CadProductsPhoenixWeb.Services.Product do

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.ProductIndex

  def fetch_all(conn) do
    case search_products(conn) do
      {:ok, products} -> {:ok, products}
      {:error, _mensage} -> {:ok, ProductIndex.get_all_product()}
    end
  end

  def search_products(conn) do
    register = ProductIndex.search_products(conn.params)
    if register == [] do
      {:error, %{code: 422, message: "Unable to search, missing params"}}
    else
      {:ok, register}
    end
  end

  def create(%{"product" => product}) when is_map(product) do
    case Management.create_register(product) do
      {:ok, _} = result ->
        {:ok, product} = result
        Cache.set(product.id, product)
        ProductIndex.index_product(product)
        result
      error -> error
    end
  end

  def create(_params), do: {:error, %{code: 422, message: "Unable to create the product, check if you are passing the json correctly"}}

  def show(product) do
    product
  end

  def show(), do: {:error, %{code: 422, message: "Unable to find the product, check if you are passing the id correctly"}}

  def update(cache_product, %{"product" => register_params} ) do
    {:ok, product} = cache_product
    case Management.update_register(product, register_params) do
      {:ok, _} = update_product ->
        Cache.set(product.id, update_product)
        ProductIndex.index_product(update_product)
        update_product
      error -> error
    end
  end

  def update(_product, _params), do: {:error, %{code: 422, message: "Unable to update the product, check if it exists or if you are passing the json correctly"}}

  def delete(cache_product) do
    {:ok, product} = cache_product
    Management.delete_register(product)
    Cache.delete(product.id)
    ProductIndex.delete_index_product(product)
  end

  def delete(), do: {:error, %{code: 422, message: "Unable to delete the product, check if it exists"}}

end
