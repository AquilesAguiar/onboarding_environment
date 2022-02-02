defmodule CadProductsPhoenix.CsvReportTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.Services.CsvReport

  def path_fixture() do
    {:ok, path} = Briefly.create()
    path
  end

  describe "CsvReport.generate_report/1" do
    test "converting map to csv" do
      path = path_fixture()
      assert CsvReport.generate_report(path) == :ok
      assert CsvReport.csv_to_map(path) != nil
    end
  end
end
