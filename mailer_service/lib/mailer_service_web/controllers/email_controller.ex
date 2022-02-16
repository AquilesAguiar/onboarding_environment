defmodule MailerServiceWeb.EmailController do
  use MailerServiceWeb, :controller
  alias MailerServiceWeb.Services.EmailService

  def send(conn, _) do
    EmailService.send(conn)
  end
end
