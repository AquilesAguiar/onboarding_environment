defmodule CadProductsPhoenixWeb.Services.Product do

  alias CadProductsPhoenix.Cache
  alias CadProductsPhoenix.Management
  alias CadProductsPhoenix.ProductIndex

  def fetch_all() do
   Cache.get("products")
    case Cache.get("products") do
      {:ok, _} = result ->
        result
      _ ->
        register = Management.list_register()
        Cache.set("products", register)
        {:ok, register}
      end
  end

  def create(%{"product" => product}) when is_map(product) do
    case Management.create_register(product) do
      {:ok, _} = result ->
        Cache.delete("products")
        ProductIndex.index_product(result)
        result
      error -> error
    end
  end

  def create(_params), do: {:error, %{code: 422, message: "Unable to create the product, check if you are passing the json correctly"}}

  def update(product, %{"product" => register_params} ) do
    case Management.update_register(product, register_params) do
      {:ok, _} ->
        Cache.delete("products")
        ProductIndex.index_product({:ok, product})
        {:ok, product}
      error -> error
    end
  end

  def update(_product, _params), do: {:error, %{code: 422, message: "Unable to update the product, check if it exists or if you are passing the json correctly"}}

  def delete(product) do
    Management.delete_register(product)
    Cache.delete("products")
    ProductIndex.delete_index_product(product)
  end

  def delete(_product), do: {:error, %{code: 422, message: "Unable to delete the product, check if it exists"}}

end
