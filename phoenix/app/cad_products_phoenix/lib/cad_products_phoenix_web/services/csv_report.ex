defmodule CadProductsPhoenix.Services.CsvReport do
  alias CadProductsPhoenix.Management

  def generate_report(path) do
    products = product_json(Management.list_register())

    file = File.open!(path, [:write, :utf8])

    csv_stream = CSV.Encoding.Encoder.encode(products, headers: true)
    Enum.each(csv_stream, &IO.write(file, &1))
  end

  defp product_json(products) do
    Enum.map(products, fn prod ->
      %{
        sku: prod.sku,
        name: prod.name,
        price: prod.price,
        qtd: prod.qtd,
        description: prod.description,
        barcode: prod.barcode
      }
    end)
  end
end
