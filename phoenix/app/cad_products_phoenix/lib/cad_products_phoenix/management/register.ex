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
  def changeset(register, attrs, action) do
    register
    |> cast(attrs, [:sku, :name, :price, :qtd, :description, :barcode])
    |> verify_sku_unique(:sku, action)
    |> validate_required([:name, :sku])
    |> validate_number(:price, greater_than: 0)
    |> validate_length(:barcode, min: 8, max: 13)
    |> validate_format(:sku, ~r/^([a-zA-Z0-9]|\-)+$/,
      message: "Accept only alphanumerics and hifen"
    )
  end

  def verify_sku_unique(changeset, field, action) do

    sku = get_field(changeset, field)
    if action == "updt" do
      changeset
    else
      if is_nil(Repo.one(from p in Register, where: p.sku == ^sku)) do
        changeset
      else
        add_error(changeset, :sku, "Sku already exists")
      end
    end
  end
end
