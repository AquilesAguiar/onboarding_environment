defmodule CadProductsPhoenix.Services.CsvReport do
  def generate_report(map) do
    file = File.open!("#{get_folder()}report_products.csv", [:write, :utf8])

    csv_stream = CSV.Encoding.Encoder.encode(map, headers: true)
    Enum.each(csv_stream, &IO.write(file, &1))
  end

  def delete_file(), do: File.rm("#{get_folder()}report_products.csv")

  defp get_folder(), do: Application.get_env(:cad_products_phoenix, :csv_folder)[:folder]
end
