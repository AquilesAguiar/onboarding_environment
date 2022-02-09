defmodule MailerService.SendEmail do

  alias MailerService.Email
  alias MailerService.Mailer

  def send_create_email() do
    Email.create_email()
    |> Mailer.deliver_later()
  end
end
