defmodule CadProductsPhoenix.Services.CsvReport do
  def tocsv(map) do
    file = File.open!("#{get_folder()}report_products.csv", [:write, :utf8])

    atom_to_string(map)
    |> CSV.Encoding.Encoder.encode(headers: true)
    |> Enum.each(&IO.write(file, &1))
  end

  def delete_file(), do: File.rm("#{get_folder()}report_products.csv")

  defp atom_to_string(map) do
    Enum.map(map, fn each_map -> Map.new(each_map, fn {k, v} -> {Atom.to_string(k), v} end) end)
  end

  defp get_folder(), do: Application.get_env(:cad_products_phoenix, :csv_folder)[:folder]
end
