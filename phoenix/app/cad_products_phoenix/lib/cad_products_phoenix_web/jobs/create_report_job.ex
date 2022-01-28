defmodule CadProductsPhoenixWeb.Jobs.CreateReportJob do
  alias CadProductsPhoenix.Services.CsvReport
  def perform(map) do
    CsvReport.tocsv(map)
  end

end
