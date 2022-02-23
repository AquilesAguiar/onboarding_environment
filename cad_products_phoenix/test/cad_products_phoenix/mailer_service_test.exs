defmodule CadProductsPhoenix.MailerServiceTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock
  alias CadProductsPhoenix.Services.HttpSevice
  alias CadProductsPhoenix.Services.MailerService

  @body %{
    "to" => "clientb2wtest@gmail.com",
    "from" => "test@gmail.com",
    "subject" => "Report products test",
    "html_body" => "<a href=#{MailerService.get_link()}> Report Products test</a>",
    "text_body" => MailerService.get_link()
  }

  @resp_body %HTTPoison.Request{
      body: "{\"to\":\"clientb2wtest@gmail.com\",\"text_body\":\"http://localhost:4000/report/\",\"subject\":\"Report products test\",\"html_body\":\"<a href=http://localhost:4000/report/> Report Products test</a>\",\"from\":\"test@gmail.com\"}",
      headers: [{"Content-Type", "application/json"}],
      method: :post,
      options: [],
      params: %{},
      url: "http://localhost:4444/send"
    }


  describe "MailerService.send_body_email/0" do
    test "send a email to the mailer" do
      with_mock HttpSevice,
        post: fn
          _ -> @resp_body
        end do
          assert MailerService.send_body_email() == @resp_body
          assert HttpSevice.post(@body) == @resp_body
      end
    end
  end
end
