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
  setup do
    CsvReport.delete_file()
    :ok
  end

  describe "CsvReport.tocsv/1" do
    test "converting map to csv" do
      assert CsvReport.tocsv(@product) == :ok
      assert CsvReport.delete_file() == :ok
    end
  end
end
