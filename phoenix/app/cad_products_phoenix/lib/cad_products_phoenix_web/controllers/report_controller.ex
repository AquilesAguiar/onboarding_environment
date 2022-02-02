defmodule CadProductsPhoenixWeb.ReportController do
  use CadProductsPhoenixWeb, :controller

  action_fallback CadProductsPhoenixWeb.FallbackController

  @path "lib/cad_products_phoenix_web/reports/report_products.csv"

  def index(conn, _), do: send_download(conn, {:file, @path})


  def create(conn, _) do
    Exq.enqueue(Exq, "report", CadProductsPhoenixWeb.Jobs.CreateReportJob, [@path])
    send_resp(conn, 200, "report create")
  end
end
