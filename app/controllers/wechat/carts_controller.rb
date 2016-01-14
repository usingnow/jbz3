class Wechat::CartsController < ApplicationController
  layout 'wechat'
  before_action :set_cart, only: [:show, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @line_items = @cart.line_items
  end

  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: '购物车已经清空。' }
      format.json { head :no_content }
    end
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.require(:line_item).permit()
    end

    def invalid_cart
      logger.error "错误的购物车id: #{params[:id]}。"
      redirect_to root_url, notice: "您要显示的购物车不存在。"
    end
end
