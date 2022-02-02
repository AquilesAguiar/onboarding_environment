defmodule CadProductsPhoenixWeb.Jobs.CreateReportJob do
  alias CadProductsPhoenix.Services.CsvReport

  def perform() do
    CsvReport.generate_report()
  end
end
