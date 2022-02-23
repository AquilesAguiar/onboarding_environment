defmodule CadProductsPhoenix.Services.MailerService do
  alias CadProductsPhoenix.Services.HttpSevice

  def send_body_email!() do
    body = convert_body_email()
    HttpSevice.post!(body)
  end

  defp convert_body_email do
    body = %{
      "to" => "clientb2w@gmail.com",
      "from" => "aquiles@gmail.com",
      "subject" => "Report products",
      "html_body" => "<a href=#{get_link()}> Report Products</a>",
      "text_body" => get_link()
    }

    Poison.encode!(body, [])
  end

  def get_link, do: Application.get_env(:cad_products_phoenix, :report_link)
end
