defmodule CadProductsPhoenix.Services.MailerService do
  @link "http://localhost:4000/report/"
  def send_body_email() do
    body = convert_body_email()

    case HTTPoison.post("http://localhost:4444/send", "{\"email_params\": \"#{body}\"}", [
           {"Content-Type", "application/json"}
         ]) do
      {:ok, _} -> {:ok, 200}
      {:error, _} -> {:error, 503}
    end
  end

  defp convert_body_email do
    body = %{
      "to" => "clientb2w@gmail.com",
      "from" => "aquiles@gmail.com",
      "subject" => "Report products",
      "html_body" => "<a href=#{@link}> Report Products </a>",
      "text_body" => "http://localhost:4000/report/"
    }

    data = Poison.encode!(body, [])
    Base.encode64(data, [])
  end
end
