class Wechat::OrdersController < ApplicationController
  layout 'wechat'

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :update, :query_points_for, :adjust_points_for]

  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: "您的购物车是空的哟，亲！"
      return
    end
    
    @order = Order.new

    # 用户未登录时不能进行“加入购物车”的逻辑，后台自动创建用户的逻辑之后加到“立即购买”中
    # 新建订单的时候，根据用户是否登录，显示不同的 form
    # if user_signed_in? 
    # @order.user_id = current_user.id
    # @order.name = current_user.name? ? current_user.name : "尚待填写"
    # @order.cellphone = current_user.cellphone
    # @order.id_card = current_user.id_card? ? current_user.id_card : "尚待填写" 
    # @order.creditcard_num = current_user.creditcard_num? ? current_user.creditcard_num : "尚待填写"
    # @order.email = current_user.email? ? current_user.email : "尚待填写"
    # else
      
    #   redirect_to new_user_session_url, notice: "请先登录后再选购，谢谢！"
    # end
  end

  def create

    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.ref = Order.create_ref
    @order.total_amount = @cart.total_amount
    @order.total_reward = @cart.total_reward
    
    respond_to do |format|
      if @order.save
        # if user_signed_in?
          # current_user.orders << @order
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to query_points_for_wechat_order_path(@order.id) }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order.update(order_params)
    if @order.dynamic_key == @order.request_dynamic_passwords.last.dynamic_key
      if @order.adjust_point.process_spdb_api(@order)
        redirect_to root_url, notice: "积分扣除成功。"
      else
        logger.error "&&&&& 积分扣除失败。#{@order.ref} && #{@order.id}"
        redirect_to root_url, alert: "扣除失败，请稍后重新尝试。"
      end
    else
      redirect_to new_wechat_adjust_point_url, notice: "验证码错误。"
    end
  end

  def show

  end

  def query_points_for
    query_point = QueryPoint.new
    @order.query_points << query_point

    reward = query_point.process_spdb_api(@order)

    if reward > @order.total_reward
      session[:order_id] = @order.id
      redirect_to new_wechat_adjust_point_path, notice: "可用积分#{reward}。"
    else
      redirect_to root_url, alert: "积分不足。请查证后再申请。" # This is the place need to revise all the user center url.
    end
  end

  def adjust_points_for

  end

  def search_by_id_card_for

  end

  def result_of_search_by_id_card
    if params[:search] == ""
      redirect_to search_by_id_card_for_wechat_orders_url, alert: "不能搜索空字段。"
    else
      @orders = Order.search(params[:search])
      if @orders.empty?
        redirect_to root_url, alert: "查无此单。请确认身份证号是否准确。"
      else
        @orders
      end
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :creditcard_num, :email, :cellphone, :address, :id_card, :ref, :dynamic_key, :bank, :debitcard_num)
    end
end
