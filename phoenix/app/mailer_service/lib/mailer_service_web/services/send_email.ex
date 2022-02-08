defmodule MailerService.SendEmail do

  alias MailerService.Email
  alias MailerService.Mailer

  def send_welcome_email() do
    Email.welcome_email()   # Create your email
    |> Mailer.deliver_later() # Send your email
  end
end
