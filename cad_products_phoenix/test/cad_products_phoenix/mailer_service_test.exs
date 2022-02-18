defmodule CadProductsPhoenix.MailerServiceTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  import Mock

  alias CadProductsPhoenix.Services.HttpSevice
  alias CadProductsPhoenix.Services.MailerService

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
