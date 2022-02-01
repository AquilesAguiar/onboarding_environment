defmodule CadProductsPhoenixWeb.Jobs.CreateReportJob do
  alias CadProductsPhoenix.Services.CsvReport

  def perform(map) do
    CsvReport.generate_report(map)
  end
end
