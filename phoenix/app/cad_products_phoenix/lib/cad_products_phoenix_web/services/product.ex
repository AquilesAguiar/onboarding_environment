defmodule CadProductsPhoenixWeb.Services.Product do

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.ProductIndex

  def fetch_products(params) do
    {:ok, ProductIndex.search_products(params)}
  end

  def create(%{"product" => product}) when is_map(product) do
    case Management.create_register(product) do
      {:ok, product} = _result ->
        Cache.set(product.id, product)
        ProductIndex.create_product(product)
        product
      error -> error
    end
  end

  def create(_params), do: {:error, %{code: 422, message: "Unable to create the product, check if you are passing the json correctly"}}

  def show(product) do
    product
  end

  def show(_product), do: {:error, %{code: 422, message: "Unable to find the product, check if you are passing the id correctly"}}

  def update({:ok, product}, %{"product" => register_params} ) do
    case Management.update_register(product, register_params) do
      {:ok, update_product} = _result ->
        Cache.set(product.id, update_product)
        ProductIndex.create_product(update_product)
        update_product
      error -> error
    end
  end

  def update(_product, _params), do: {:error, %{code: 422, message: "Unable to update the product, check if it exists or if you are passing the json correctly"}}

  def delete({:ok, product}) do
    Management.delete_register(product)
    Cache.delete(product.id)
    ProductIndex.delete_product(product)
  end

  def delete(_product), do: {:error, %{code: 422, message: "Unable to delete the product, check if it exists"}}

end
