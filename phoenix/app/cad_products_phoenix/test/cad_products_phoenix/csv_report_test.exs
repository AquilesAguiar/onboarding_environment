defmodule CadProductsPhoenix.CsvReportTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.Services.CsvReport

  defp path_fixture() do
    {:ok, path} = Briefly.create()
    path
  end

  defp csv_to_map(path) do
    File.stream!(path)
    |> CSV.decode()
    |> Enum.to_list()
  end

  describe "CsvReport.generate_report/1" do
    test "converting map to csv" do
      path = path_fixture()
      assert CsvReport.generate_report(path) == :ok
      assert csv_to_map(path) != nil
    end
  end
end
