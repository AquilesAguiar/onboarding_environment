defmodule MailerService.Services.Cache do
  @conn :redis_server

  # Set a binary hash
  def set(key, value) do
    bin = encode(value)
    Redix.command(@conn, ["SET", key, bin])
  end

  # Get a get a binary and decode
  def get(key) do
    decode(Redix.command(@conn, ["GET", key]))
  end

  # Delete products
  def delete(key) do
    Redix.command(@conn, ["DEL", key])
  end

  def flush() do
    Redix.command(@conn, ["FLUSHDB"])
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

  def get_conn(), do: @conn
end
