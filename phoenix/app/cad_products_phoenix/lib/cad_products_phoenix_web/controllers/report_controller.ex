defmodule CadProductsPhoenixWeb.ReportController do
  use CadProductsPhoenixWeb, :controller

  action_fallback CadProductsPhoenixWeb.FallbackController

  @path "../tmp/report_products.csv"

  def index(conn, _) do
    send_download(conn, {:file, @path})
  end

  def create(conn, _) do
    case Exq.enqueue(Exq, "report", CadProductsPhoenixWeb.Jobs.CreateReportJob, [@path]) do
      {:ok, _id} -> send_resp(conn, 202, "")
      _error -> send_resp(conn, 503, "failed to created report")
    end
  end
end
