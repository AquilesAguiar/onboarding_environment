defmodule MailerServiceWeb.Services.EmailService do
  use MailerServiceWeb, :controller

  alias MailerServiceWeb.Services.SendEmail

  def send(conn) do
    body = conn.params

    SendEmail.send_create_email(body)

    conn
    |> put_status(200)
    |> send_resp(200, "The email was sent correctly")
  end
end
