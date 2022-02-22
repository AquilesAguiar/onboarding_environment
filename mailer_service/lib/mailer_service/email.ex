defmodule MailerService.Email do
  import Bamboo.Email

  def create_email(content) do
    {:ok, content} = Poison.decode(content)
    new_email(
      to: content["to"],
      from: content["from"],
      subject: content["subject"],
      html_body: content["html_body"],
      text_body: content["text_body"]
    )
  end
end
