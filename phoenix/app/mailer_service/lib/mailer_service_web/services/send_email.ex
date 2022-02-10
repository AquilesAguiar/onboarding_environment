defmodule MailerService.SendEmail do
  alias MailerService.Email
  alias MailerService.Mailer

  def send_create_email(email_body) do
    Email.create_email(email_body)
    |> Mailer.deliver_later()
  end
end
