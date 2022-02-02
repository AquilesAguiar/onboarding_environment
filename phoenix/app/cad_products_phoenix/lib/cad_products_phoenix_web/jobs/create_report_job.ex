defmodule CadProductsPhoenixWeb.Jobs.CreateReportJob do
  alias CadProductsPhoenix.Services.CsvReport

  def perform(path) do
    CsvReport.generate_report(path)
  end
end
