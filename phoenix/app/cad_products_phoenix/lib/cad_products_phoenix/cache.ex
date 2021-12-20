defmodule CadProductsPhoenix.Cache do
  @conn :redis_server

  # Set products
  def set_product(key, value), do: Redix.command(@conn, ["SET", key, value |> :erlang.term_to_binary |> Base.encode16()])

  # Get products
  def get_product(key), do: Redix.command(@conn, ["GET", key]) |> decode

  defp decode({:ok, nil}), do: {:not_found, "key not found"}

  defp decode({:ok, val}) do
    {:ok, bin} = val |> Base.decode16()
    {:ok, bin |> :erlang.binary_to_term()}
  end

  # Delete products
  def delete_product(key), do: Redix.command(@conn, ["DEL", key])

end
