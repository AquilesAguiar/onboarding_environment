defmodule MailerServiceWeb.Services.EmailService do
  use MailerServiceWeb, :controller

  alias MailerService.Services.Cache
  alias MailerServiceWeb.Services.SendEmail

  def send(conn) do
<<<<<<< HEAD
    {:ok, body_email} = Cache.get("email_params")
    SendEmail.send_create_email(body_email)
=======
    body = conn.params

    SendEmail.send_create_email(body)
>>>>>>> parent of f38e5a9 (Saving email data in redis)

    conn
    |> put_status(200)
    |> send_resp(200, "The email was sent correctly")
  end
end
