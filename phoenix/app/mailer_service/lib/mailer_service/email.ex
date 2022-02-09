defmodule MailerService.Email do
  import Bamboo.Email

  def create_email(email) do
    content = convert_content(email.data)

    new_email(
      to: email.to,
      from: email.from,
      subject: email.subject,
      html_body: email.html_body,
      text_body: email.text_body
    )
    |> put_attachment(%Bamboo.Attachment{content_type: email.content_type, filename: email.filename, data: content})
  end

  defp convert_content(data) do
    {:ok, content} = Base.decode64(data)
    content
  end
end
