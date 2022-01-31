defmodule CadProductsPhoenix.Services.CsvReport do
  def tocsv(map) do
    file = File.open!("#{get_folder()}report_products.csv", [:write, :utf8])
    CSV.Encoding.Encoder.encode(map, headers: true)
    |> Enum.each(&IO.write(file, &1))
  end

  def delete_file(), do: File.rm("#{get_folder()}report_products.csv")

  defp get_folder(), do: Application.get_env(:cad_products_phoenix, :csv_folder)[:folder]
end
