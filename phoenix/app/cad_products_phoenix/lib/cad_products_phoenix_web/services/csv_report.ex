defmodule CadProductsPhoenix.Services.CsvReport do
  alias CadProductsPhoenix.Management

  def generate_report() do
    products = product_json(Management.list_register())

    file = File.open!("#{get_folder()}report_products.csv", [:write, :utf8])

    csv_stream = CSV.Encoding.Encoder.encode(products, headers: true)
    Enum.each(csv_stream, &IO.write(file, &1))
  end

  def delete_file(), do: File.rm("#{get_folder()}report_products.csv")

  defp get_folder(), do: Application.get_env(:cad_products_phoenix, :csv_folder)[:folder]

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
