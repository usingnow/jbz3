class Wechat::OrdersController < ApplicationController
  layout 'wechat'

  include CurrentCart
  before_action :set_order, only: [:show]

  def new
    @order = Order.new
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :creditcard_num, :email, :cellphone, :address)
    end
end
