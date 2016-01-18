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
    if user_signed_in? 
      @order.user_id = current_user.id
      @order.name = current_user.name.empty? ? "尚待填写" : current_user.name
      @order.cellphone = current_user.cellphone
      @order.id_card = current_user.id_card.empty? ? "尚待填写" : current_user.id_card
      @order.creditcard_num = current_user.creditcard_num.empty? ? "尚待填写" : current_user.creditcard_num
      @order.email = current_user.email.empty? ? "尚待填写" : current_user.email
      @order.address = current_user.address.empty? ? "尚待填写" : current_user.address
    end
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.ref = Order.create_ref
    
    respond_to do |format|

      if user_signed_in?
        current_user.orders << @order
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to root_url, notice: "您的兑换已经成功，请前往 \"用户中心\" -> \"我的订单\" 查看，谢谢！" }
        format.json { render action: 'show', status: :created, location: @order }

      else
        if @order.save
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          @usernow = User.create!(name: @order.name, cellphone: @order.cellphone, password: "12121212", 
                       creditcard_num: @order.creditcard_num, id_card: @order.id_card, 
                       address: @order.address, email: @order.email)
          @usernow.orders << @order

          format.html { redirect_to root_url, notice: "您的兑换已经成功，谢谢！" }
          format.json { render action: 'show', status: :created, location: @order }
        else
          format.html { render action: 'new' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
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
