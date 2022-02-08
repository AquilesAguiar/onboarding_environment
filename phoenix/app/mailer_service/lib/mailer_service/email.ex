defmodule MailerService.Email do
  import Bamboo.Email

  def welcome_email do
    new_email(
      to: "aquiles.aguiar@b2wdigital.com",
      from: "aquilesvibe@hotmail.com",
      subject: "teste do mailer",
      html_body: "<strong>Thanks for joining!</strong>",
      text_body: "Thanks for joining!"
    )
    |> put_attachment(%Bamboo.Attachment{content_type: "image/jpg", filename: "unnamed.jpg", data: "content", content_id: "2343333333"})
  end
end
