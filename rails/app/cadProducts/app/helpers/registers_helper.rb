# frozen_string_literal: true

# This helper is responsible for controller registers
module RegistersHelper
  def json_config(registers)
    if registers.respond_to?(:map)
      registers.map do |register|
        to_json(register)
      end
    else
      to_json(registers)
    end
  end

  def to_json(register)
    {
      sku: register.sku,
      name: register.name,
      description: register.description,
      price: register.price,
      qtd: register.qtd
    }
  end

end
