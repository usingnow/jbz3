class Wechat::OrdersController < ApplicationController
  layout 'wechat'

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show]

  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "您的购物车是空的哟，亲！"
      return
    end
    
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.user_id = current_user.id
    @order.ref = Order.create_ref
    # current_user.orders << @order

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        session[:order_id] = @order.id

        format.html { redirect_to new_wechat_query_point_path, notice: "您的兑换已经成功，谢谢！" }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :creditcard_num, :email, :cellphone, :address, :id_card, :ref)
    end
end
