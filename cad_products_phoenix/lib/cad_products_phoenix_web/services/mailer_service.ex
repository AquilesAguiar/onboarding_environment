defmodule CadProductsPhoenix.Services.MailerService do
  alias CadProductsPhoenix.Services.HttpSevice

  def send_body_email() do
    body = convert_body_email()
    HttpSevice.post(body)
  end

  defp convert_body_email do
    %{
      "to" => "clientb2wtest@gmail.com",
      "from" => "test@gmail.com",
      "subject" => "Report products test",
      "html_body" => "<a href=#{get_link()}> Report Products test</a>",
      "text_body" => get_link()
    }
  end

  def get_link, do: Application.get_env(:cad_products_phoenix, :report_link)
end
