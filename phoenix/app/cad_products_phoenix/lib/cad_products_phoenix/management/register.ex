defmodule CadProductsPhoenix.Management.Register do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "registers" do
    field :sku, :string
    field :name, :string
    field :description, :string
    field :price, :float
    field :qtd, :integer
    field :barcode, :string
  end

  @doc false
  def changeset(register, attrs) do
    register
    |> cast(attrs, [:sku, :name, :price, :qtd, :description, :barcode])
    |> validate_required([:name])
    |> validate_number(:price, greater_than: 0)
    |> validate_length(:barcode, min: 8, max: 10)
    |> validate_format(:sku, ~r/^([a-zA-Z0-9]|\-)+$/, message: "Accept only alphanumerics and hifen")
  end
end
