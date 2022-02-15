defmodule CadProductsPhoenixWeb.ReportControllerTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  @string_report "barcode,description,name,price,qtd,sku\r\n,morango,pá,15.0,85,olha\r\n,morango,pá,15.0,85,slkjfoa\r\n,morango,pá,15.0,85,dlskjdfp\r\n"
  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "show report", %{conn: conn} do
      conn = get(conn, Routes.report_path(conn, :index))
      assert conn.resp_body == @string_report
    end
  end

  describe "create" do
    test "crete report", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create))
      assert conn.resp_body == ""
    end
  end
end
