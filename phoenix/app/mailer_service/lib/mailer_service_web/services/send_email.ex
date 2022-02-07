defmodule MailerService.SendEmail do

  alias MailerService.Mailer
  alias MailerService.Email

  def send_welcome_email do
    Email.welcome_email()   # Create your email
    |> Mailer.deliver_now!() # Send your email
  end
end
