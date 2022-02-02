defmodule CadProductsPhoenixWeb.ReportController do
  use CadProductsPhoenixWeb, :controller

  action_fallback CadProductsPhoenixWeb.FallbackController

  @path "lib/cad_products_phoenix_web/reports/report_products.csv"

  def create(conn, _) do
    case Exq.enqueue(Exq, "report", CadProductsPhoenixWeb.Jobs.CreateReportJob, []) do
      {:ok, _} -> send_download(conn, {:file, @path})
      {:error, message} -> send_resp(conn, 400, message)
    end
  end
end
