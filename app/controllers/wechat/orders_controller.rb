class Wechat::OrdersController < ApplicationController
  layout 'wechat'

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show,]

  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "您的购物车是空的哟，亲！"
      return
    end
    
    @order = Order.new
    # 新建订单的时候，根据用户是否登录，显示不同的 form
    if user_signed_in? 
      @order.user_id = current_user.id
      @order.name = current_user.name? ? current_user.name : "尚待填写"
      @order.cellphone = current_user.cellphone
      @order.id_card = current_user.id_card? ? current_user.id_card : "尚待填写" 
      @order.creditcard_num = current_user.creditcard_num? ? current_user.creditcard_num : "尚待填写"
      @order.email = current_user.email? ? current_user.email : "尚待填写"
      @order.address = current_user.address? ? current_user.address : "尚待填写"
    end
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.ref = Order.create_ref
    @order.total_amount = @cart.total_amount
    @order.total_reward = @cart.total_reward
    
    respond_to do |format|
      if @order.save
        if user_signed_in?
          current_user.orders << @order
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil

        else 
          # 逻辑有误，此时 order 已经保存，手机号必定重复，而且 user 也会建立，这个方法不管用

          # Rails 使用有误，改用正确的 Rais api 实现。先着手解决浦发api的问题，再回来处理。
          # Order.all.each do |order|
          #   if order.cellphone == @order.cellphone
          #     format.html { redirect_to root_url, notice: "手机号重复，请重新购买，谢谢！" }
          #   end
          # end

          session[:order_id] = @order.id

          # 路人用户在创建订单的时候，后台自动创建 user 账户，并且将订单挂到该新用户账户
          @usernow = User.create!(name: @order.name, cellphone: @order.cellphone, password: "12121212", 
                                  creditcard_num: @order.creditcard_num, id_card: @order.id_card, 
                                  address: @order.address, email: @order.email)
          @usernow.orders << @order
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil

        end
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
