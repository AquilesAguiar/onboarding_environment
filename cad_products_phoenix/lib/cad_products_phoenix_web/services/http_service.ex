defmodule CadProductsPhoenix.Services.HttpSevice do
  def post(body) do
    case HTTPoison.post("http://localhost:4444/send", "{\"email_params\": \"#{body}\"}", [
           {"Content-Type", "application/json"}
         ]) do
      {:ok, _} -> {:ok, 200}
      {:error, _} -> {:error, 503}
    end
  end
end
