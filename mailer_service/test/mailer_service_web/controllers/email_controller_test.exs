defmodule MailerServiceWeb.EmailControllerTest do
  use MailerServiceWeb.ConnCase, async: false

  @email_attrs %{
    "to" => "testclientb2w@gmail.com",
    "from" => "testaquilesb2w@gmail.com",
    "subject" => "Report products test",
    "html_body" => "<strong> Report delivered </strong>",
    "text_body" => "Report delivered",
    "content_type" => "application/csv",
    "filename" => "report_products.csv",
    "data" => "test/mailer_service_web/report/report_model.csv"
  }
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "send" do
    test "send email with email", %{conn: conn} do
      data = Poison.encode!(@email_attrs, [])
      body = Base.encode64(data)
      conn = post(conn, Routes.email_path(conn, :send), %{email_params: body})
      assert conn.resp_body == "The email was sent correctly"
    end
  end
end
