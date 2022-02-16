defmodule MailerServiceWeb.Services.SendEmail do
  alias MailerService.Email
  alias MailerService.Mailer

  def send_create_email(email_body) do
    email = Email.create_email(email_body)
    Mailer.deliver_later(email)
  end
end
