defmodule CadProductsPhoenixWeb.RegisterView do
  use CadProductsPhoenixWeb, :view

  alias CadProductsPhoenixWeb.RegisterView

  def render("index.json", %{register: register}) do
    %{products: render_many(register, RegisterView, "register.json")}
  end

  def render("show.json", %{register: register}) do
    %{product: render_one(register, RegisterView, "register.json")}
  end

  def render("register.json", %{register: register}) do
    %{
      id: register.id,
      sku: register.sku,
      name: register.name,
      price: register.price,
      qtd: register.qtd,
      description: register.description,
      barcode: register.barcode
    }
  end
end
