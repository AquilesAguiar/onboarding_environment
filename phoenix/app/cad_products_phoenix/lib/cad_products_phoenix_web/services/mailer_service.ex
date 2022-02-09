defmodule CadProductsPhoenix.Services.MailerService do
  def send_body_email do
    HTTPoison.post "http://localhost:5000/email/send", "{\"body\": \"test\"}", [{"Content-Type", "application/json"}]
  end

  defp body_email do

    body = %{
      to: "clientb2w@gmail.com",
      from: "clientb2w@gmail.com",
      subject: "Report products",
      html_body: "<strong> Report delivered </strong>",
      text_body: "Report delivered",
      content_type: "application/csv",
      filename: "report_products.csv",
      data: content
    }
  end
end
