defmodule MailerServiceWeb.EmailController do
  use MailerServiceWeb, :controller
  alias MailerService.SendEmail

  def send(conn, _) do
    body = conn.body_params["body"]
    SendEmail.send_create_email(body)
    send_resp(conn, 200, "success")
  end
end
