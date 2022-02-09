defmodule CadProductsPhoenixWeb.ReportController do
  use CadProductsPhoenixWeb, :controller

  alias CadProductsPhoenix.Services.MailerService

  action_fallback CadProductsPhoenixWeb.FallbackController

  @path "lib/cad_products_phoenix_web/reports/report_products.csv"

  def index(conn, _) do
    MailerService.send_body_email()
    send_download(conn, {:file, @path})
  end

  def create(conn, _) do
    case Exq.enqueue(Exq, "report", CadProductsPhoenixWeb.Jobs.CreateReportJob, [@path]) do
      {:ok, _id} -> send_resp(conn, 202, "")
      _error -> send_resp(conn, 503, "failed to created report")
    end
  end
end
