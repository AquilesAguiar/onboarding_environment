defmodule CadProductsPhoenix.Repo.Migrations.CreateRegister do
  use Ecto.Migration

  def change do
    create table(:register, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :sku, :string
      add :name, :string
      add :price, :float
      add :qtd, :float
      add :description, :string

      timestamps()
    end

  end
end
