defmodule CadProductsPhoenix.MailerServiceTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock

  alias CadProductsPhoenix.Services.Cache
  alias CadProductsPhoenix.Services.MailerService

  @body %{
    "to" => "clientb2wtest@gmail.com",
    "from" => "test@gmail.com",
    "subject" => "Report products test",
    "html_body" => "<a href=#{MailerService.get_link()}> Report Products test</a>",
    "text_body" => MailerService.get_link()
  }

  describe "MailerService.send_body_email/0" do
    test "send a email to the mailer" do
      with_mock Cache,
        set: fn
          _, _ -> {:ok, "OK"}
        end do
        assert Cache.set("email_params", @body) == {:ok, "OK"}
        assert MailerService.send_body_email() == {:ok, "OK"}
      end
    end
  end
end
