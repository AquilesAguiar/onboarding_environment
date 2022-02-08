defmodule MailerService.SendEmail do

  alias MailerService.Email
  alias MailerService.Mailer

  def send_welcome_email() do
    Email.welcome_email()
    |> Mailer.deliver_later()
  end
end
