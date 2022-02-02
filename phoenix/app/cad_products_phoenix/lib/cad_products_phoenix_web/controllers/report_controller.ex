defmodule CadProductsPhoenixWeb.ReportController do
  use CadProductsPhoenixWeb, :controller

  action_fallback CadProductsPhoenixWeb.FallbackController

  @path "lib/cad_products_phoenix_web/reports/report_products.csv"

  def index(conn, _), do: send_download(conn, {:file, @path})

  def create(conn, _) do
    case Exq.enqueue(Exq, "report", CadProductsPhoenixWeb.Jobs.CreateReportJob, [@path]) do
      {:ok, _id} -> send_resp(conn, 200, "report created")
      _error -> send_resp(conn, 400, "failed to created report")
    end
  end
end
