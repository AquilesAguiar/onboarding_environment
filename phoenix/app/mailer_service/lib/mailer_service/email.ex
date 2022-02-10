defmodule MailerService.Email do
  import Bamboo.Email

  def create_email(email) do
    content = convert_content(email)

    new_email(
      to: content["to"],
      from: content["from"],
      subject: content["subject"],
      html_body: content["html_body"],
      text_body: content["text_body"]
    )
    |> put_attachment(%Bamboo.Attachment{
      content_type: content["content_type"],
      filename: content["filename"],
      data: content["data"]
    })
  end

  defp convert_content(data) do
    {:ok, content} = Base.decode64(data)
    Poison.decode!(content, [])
  end
end
