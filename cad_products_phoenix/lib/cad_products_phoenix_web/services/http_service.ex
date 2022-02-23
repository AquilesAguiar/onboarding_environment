defmodule CadProductsPhoenix.Services.HttpSevice do
  def post!(body) do
    HTTPoison.post!(getlink(), body, [
      {"Content-Type", "application/json"}
    ]).request
  end

  def getlink, do: Application.get_env(:cad_products_phoenix, :mailer_link)
end
