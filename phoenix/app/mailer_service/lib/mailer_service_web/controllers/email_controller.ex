defmodule MailerServiceWeb.EmailController do
  use MailerServiceWeb, :controller
  alias MailerService.SendEmail

  def send(conn,_ ) do
    SendEmail.send_welcome_email()
    send_resp(conn, 200, "success")
  end
end
