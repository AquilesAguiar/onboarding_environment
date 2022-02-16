defmodule CadProductsPhoenix.Services.MailerService do
  def send_body_email do
    body = convert_body_email()
    HTTPoison.post "http://localhost:4444/send", "{\"email_params\": \"#{body}\"}", [{"Content-Type", "application/json"}]
  end

  defp convert_body_email do
    body = %{
      "to" => "clientb2w@gmail.com",
      "from" => "aquiles@gmail.com",
      "subject" => "Report products",
      "html_body" => "<strong> Report delivered </strong>",
      "text_body" => "Report delivered",
      "content_type" => "application/csv",
      "filename" => "report_products.csv",
      "data" => "../tmp/report_products.csv"
    }
    data = Poison.encode!(body, [])
    Base.encode64(data, [])
  end
end
