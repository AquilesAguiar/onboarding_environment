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
    field :last_update_at, :date

  end

  @doc false
  def changeset(register, attrs) do
    register
    |> cast(attrs, [:sku, :name, :price, :qtd, :description, :last_update_at])
    |> validate_required([:sku, :name, :price, :qtd, :description, :last_update_at])
  end
end
