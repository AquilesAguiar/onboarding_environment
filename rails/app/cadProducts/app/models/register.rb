class Register
  include Mongoid::Document

  field :sku, type: String
  field :name, type: String
  field :qtd, type: Float
  field :description, type: String
  field :price, type: Float
end
