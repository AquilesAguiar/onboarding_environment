defmodule CadProductsPhoenix.Management.Register do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias CadProductsPhoenix.Management.Register
  alias CadProductsPhoenix.Repo

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
    id = register.id

    register
    |> cast(attrs, [:sku, :name, :price, :qtd, :description, :barcode])
    |> validate_unique_sku(:sku, id)
    |> validate_required([:sku, :name])
    |> validate_number(:price, greater_than: 0)
    |> validate_length(:barcode, min: 8, max: 13)
    |> validate_format(:sku, ~r/^([a-zA-Z0-9]|\-)+$/,
      message: "Accept only alphanumerics and hifen"
    )
  end

  def validate_unique_sku(changeset, field, id) do
    sku = get_field(changeset, field)
    result = find_by_sku(sku, id)

    if is_nil(result) do
      changeset
    else
      add_error(changeset, :sku, "This sku is not unique")
    end
  end

  def find_by_sku(sku, id) do
    cond do
      sku != nil && id == nil ->
        Repo.one(from p in Register, where: p.sku == ^sku)

      sku != nil && id != nil ->
        Repo.one(from p in Register, where: p.id != ^id and p.sku == ^sku)
      true -> nil
    end
  end
end
