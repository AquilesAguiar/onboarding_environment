defmodule CadProductsPhoenix.Cache do

  def connect_server(name) do
    case Redix.start_link("redis://localhost:6379", name: name) do
      {:ok, server} -> server
      {:error, {:already_started, _}} -> name
    end
  end
  # Set a binary hash
  def set(name, key, value) do
    name = connect_server(name)
    bin = encode(value)
    Redix.command(name, ["SET", key, bin])
  end

  # Get a get a binary and decode
  def get(name, key) do
    name = connect_server(name)
    decode(Redix.command(name, ["GET", key]))
  end

  # Delete products
  def delete(name, key) do
    name = connect_server(name)
    Redix.command(name, ["DEL", key])
  end

  defp encode(value) do
    value
    |> :erlang.term_to_binary()
    |> Base.encode16()
  end

  defp decode({:ok, nil}), do: {:error, "key not found"}

  defp decode({:ok, val}) do
    {:ok, bin} = Base.decode16(val)
    {:ok, :erlang.binary_to_term(bin)}
  end
end
