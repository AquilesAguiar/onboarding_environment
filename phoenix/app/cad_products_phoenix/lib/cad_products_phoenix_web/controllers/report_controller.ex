defmodule CadProductsPhoenixWeb.ReportController do
  use CadProductsPhoenixWeb, :controller

  action_fallback CadProductsPhoenixWeb.FallbackController

  alias CadProductsPhoenix.Management

  def index(conn, _) do
    products = product_json(Management.list_register())
    path = "lib/cad_products_phoenix_web/reports/report_products.csv"

    case Exq.enqueue(Exq, "report", CadProductsPhoenixWeb.Jobs.CreateReportJob, [products]) do
      {:ok, _} -> send_download(conn, {:file, path})
      {:error, message} -> send_resp(conn, 400, message)
    end
  end

  defp product_json(products) do
    Enum.map(products, fn prod ->
      %{
        id: prod.id,
        sku: prod.sku,
        name: prod.name,
        price: prod.price,
        qtd: prod.qtd,
        description: prod.description,
        barcode: prod.barcode,
        last_update_at: DateTime.to_iso8601(DateTime.utc_now())
      }
    end)
  end
end
