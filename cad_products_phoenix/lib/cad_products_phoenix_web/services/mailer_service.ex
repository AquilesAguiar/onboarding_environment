defmodule CadProductsPhoenix.Services.MailerService do
  @link "http://localhost:4000/report/"
  alias CadProductsPhoenix.Services.HttpSevice

  def send_body_email() do
    body = convert_body_email()
    HttpSevice.post(body)
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
