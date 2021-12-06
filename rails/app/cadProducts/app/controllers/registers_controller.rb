# frozen_string_literal: true

# This controller is responsible for products
class RegistersController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_action :set_register, only: %i[show edit update destroy]
  
  def index

    registers = Register.all
    render json: view_context.json_config(registers)
  end

  def show
    @register = view_context.json_config(Register.find_by(sku: params[:id]))
    render json: @register
  end

  def create

    @register = Register.new(register_params)
    if @register.save
      render json: view_context.json_config(@register)
    else
      render json: { error: @register.errors, status: 400 }
    end
  end

  def update

    if @register.update(register_params)
      render json: { success: 'product was successfully updated' }
    else
      render json: { error: @register.errors, status: 400 }
    end
  end

  def destroy

    if @register.destroy
      render json: { success: 'product was successfully destroyed' }
    else
      render json: { error: @register.errors, status: 400 }
    end
  end

  private

  def set_register

    @register = Register.find_by(sku: params[:id])
  end

  def register_params

    params.require(:register).permit(:sku, :name, :qtd, :description, :price)
  end
end
