class Wechat::LineItemsController < ApplicationController
  layout 'wechat'

  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:redeem]

  def create
    jbz_sku = JbzSku.find(params[:jbz_sku_id])
    @line_item = @cart.add_jbz_sku(jbz_sku.id)

    if @line_item.save
      respond_to do |format|
        format.html { redirect_to [:wechat, @line_item.cart], notice: '您刚选购的产品已经成功。' }
        format.json { render :show, status: :created, location: @line_item }
      end
    else
      # flash[:alert] = "联系客服邮箱：3353512440@qq.com。" # 修正wording。
      format.html { render :new }
      format.json { render json: @line_item.errors, status: :unprocessable_entity }
    end
  end

  def redeem
    @line_item.redeemed_at = DateTime.current
    if @line_item.save
      redirect_to wechat_order_path(@line_item.order.id), notice: "订单已经成功申请赎回。"
    else
      redirect_tp root_url, alert: "订单赎回申请失败，请联系管理员。"
    end
  end


  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:jbz_sku_id, :quantity)
    end
end
