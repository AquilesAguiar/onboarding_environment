defmodule CadProductsPhoenixWeb.RegisterView do
  use CadProductsPhoenixWeb, :view
  alias CadProductsPhoenixWeb.RegisterView

  def render("index.json", %{register: register}) do
    %{data: render_many(register, RegisterView, "register.json")}
  end

  def render("show.json", %{register: register}) do
    %{data: render_one(register, RegisterView, "register.json")}
  end

  def render("register.json", %{register: register}) do
    %{sku: register.sku,
      name: register.name,
      price: register.price,
      qtd: register.qtd,
      description: register.description}
  end
end
