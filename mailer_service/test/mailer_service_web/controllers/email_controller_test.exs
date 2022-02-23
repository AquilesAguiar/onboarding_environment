defmodule MailerServiceWeb.EmailControllerTest do
  use MailerServiceWeb.ConnCase, async: false

  @email_attrs %{
    "to" => "clientb2wtest@gmail.com",
    "from" => "test@gmail.com",
    "subject" => "Report products test",
    "html_body" => "<a href=http://localhost:4000/report/> Report Products test</a>",
    "text_body" => "http://localhost:4000/report/"
  }
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "send" do
    test "send email with email", %{conn: conn} do
      conn = post(conn, Routes.email_path(conn, :send), @email_attrs)
      assert conn.resp_body == "The email was sent correctly"
    end
  end
end
