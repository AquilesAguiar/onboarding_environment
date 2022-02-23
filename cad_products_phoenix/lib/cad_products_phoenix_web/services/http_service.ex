defmodule CadProductsPhoenix.Services.HttpSevice do
  def post(body) do
    case HTTPoison.post(getlink(), body, [
           {"Content-Type", "application/json"}
         ]) do
      {:ok, resp} -> resp.request
      {:error, _} -> {:error, 503}
    end
  end

  def getlink, do: Application.get_env(:cad_products_phoenix, :mailer_link)
end
