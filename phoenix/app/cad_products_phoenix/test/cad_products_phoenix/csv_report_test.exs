defmodule CadProductsPhoenix.CsvReportTest do
  use CadProductsPhoenixWeb.ConnCase, async: false

  alias CadProductsPhoenix.Services.CsvReport

  @product [
    %{
      description: "some description",
      name: "name",
      price: 120.5,
      qtd: 120,
      sku: "78845598",
      barcode: "123456789",
      id: "61e580fc6057a40203db022e"
    }
  ]

  describe "CsvReport.generate_report/1" do
    test "converting map to csv" do
      {:ok, path} = Briefly.create()
      assert CsvReport.generate_report(path) == :ok
    end
  end
end
