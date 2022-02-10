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

    "data" => "../tmp/cad_products_phoenix/test/cad_products_phoenix_web/reports/report_model.csv"
  }
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "send" do
    test "send email with email", %{conn: conn}  do
      data = Poison.encode!(@email_attrs, [])
      body =  Base.encode64(data)
      conn = post(conn, Routes.register_path(conn, :send), email_params: body)
    end
  end
end
