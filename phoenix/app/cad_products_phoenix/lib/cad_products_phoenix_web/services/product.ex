defmodule CadProductsPhoenixWeb.Services.Product do

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.ProductIndex

  def fetch_all() do
    register = Management.list_register()
    {:ok, register}
  end

  def create(%{"product" => product}) when is_map(product) do
    case Management.create_register(product) do
      {:ok, _} = result ->
        Cache.set(result.id, result)
        ProductIndex.index_product(result)
        result
      error -> error
    end
  end

  def create(_params), do: {:error, %{code: 422, message: "Unable to create the product, check if you are passing the json correctly"}}

  def show(id) do
    {:ok, product} = get_cache(id)
    product
  end

  def show(), do: {:error, %{code: 422, message: "Unable to find the product, check if you are passing the id correctly"}}

  def update(id, %{"product" => register_params} ) do
    {:ok, product} = get_cache(id)

    case Management.update_register(product, register_params) do
      {:ok, _} = update_product ->
        Cache.delete(id)
        Cache.set(id, update_product)
        ProductIndex.index_product(update_product)
        update_product
      error -> error
    end
  end

  def update(_product, _params), do: {:error, %{code: 422, message: "Unable to update the product, check if it exists or if you are passing the json correctly"}}

  def delete(id) do
    {:ok, product} = get_cache(id)
    Management.delete_register(product)
    Cache.delete(id)
    ProductIndex.delete_index_product(product)
  end

  def delete(), do: {:error, %{code: 422, message: "Unable to delete the product, check if it exists"}}

  def get_cache(id) do
    case Cache.get(id) do
      {:ok, _} = result ->
        result
      _ ->
        register = Management.get_register(id)
        if register do
          Cache.set(id, register)
          {:ok, register}
        else
          {:error, %{code: 422, message: "Product with #{id} not found"}}
        end
    end
  end

end
