defmodule CadProductsPhoenix.Services.CsvReport do
  import CSV

  def tocsv(map) do
    name = "report#{DateTime.to_iso8601(DateTime.utc_now())}"
    file = File.open!("lib/cad_products_phoenix_web/reports/#{name}", [:write, :utf8])

    atom_to_string(map)
    |> CSV.Encoding.Encoder.encode(headers: true)
    |> Enum.each(&IO.write(file, &1))
  end

  defp atom_to_string(map) do
    Enum.map(map, fn each_map -> Map.new(each_map, fn {k, v} -> {Atom.to_string(k), v} end) end)
  end
end
