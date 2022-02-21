defmodule CadProductsPhoenix.MailerServiceTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock

  alias CadProductsPhoenix.Services.HttpSevice
  alias CadProductsPhoenix.Services.MailerService

  @body %{
    "to" => "clientb2wtest@gmail.com",
    "from" => "test@gmail.com",
    "subject" => "Report products test",
    "html_body" => "<a href=#{HttpSevice.getlink()}> Report Products test</a>",
    "text_body" => HttpSevice.getlink()
  }

  describe "MailerService.send_body_email/0" do
    test "send a email to the mailer" do
      with_mock HttpSevice,
        post: fn
          _ -> {:ok, 200}
        end do
        assert MailerService.send_body_email() == {:ok, 200}
      end
    end
  end
end
