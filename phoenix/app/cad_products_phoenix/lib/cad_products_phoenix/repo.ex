defmodule CadProductsPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :cad_products_phoenix,
    adapter: Mongo.Ecto
end
