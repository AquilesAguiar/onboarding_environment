defmodule CadProductsPhoenixWeb.Jobs.SendEmailJob do
  alias CadProductsPhoenix.Services.MailerService

  def perform() do
    MailerService.send_body_email()
  end
end
