defmodule CadProductsPhoenix.Services.MailerService do
  def send_body_email do
    body = convert_body_email()
    HTTPoison.post "http://localhost:5000/email/send", "{\"body\": \"#{body}\"}", [{"Content-Type", "application/json"}]
  end

  defp convert_body_email do
    content = read_report()
    body = %{
      "to" => "clientb2w@gmail.com",
      "from" => "clientb2w@gmail.com",
      "subject" => "Report products",
      "html_body" => "<strong> Report delivered </strong>",
      "text_body" => "Report delivered",
      "content_type" => "application/csv",
      "filename" => "report_products.csv",
      "data" => content
    }
    data = Poison.encode!(body, [])
    Base.encode64(data, [])
  end

  defp read_report do
    {:ok, result} = File.read("lib/cad_products_phoenix_web/reports/report_products.csv")
    result
  end
end
