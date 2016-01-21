class Wechat::AdjustPointsController < ApplicationController
  layout 'wechat'

  before_action :set_adjust_point, only: [:show]

  def new
    @adjust_point = AdjustPoint.new
    @order = Order.find(session[:order_id])
  end

  def create
    @adjust_point = AdjustPoint.new(adjust_point_params)

    @adjust_point.request = @adjust_point.build_req(@adjust_point.creditcard_num)
    @adjust_point.order_id = session[:order_id]
    @adjust_point.user_id = current_user.id

    respond_to do |format|
      if @adjust_point.save
        format.html { render new_wechat_request_dynamic_password_path, notice: '请确认以下信息。' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    def set_adjust_point
      @adjust_point = AdjustPoint.find(params[:id])
    end

    def adjust_point_params
      params.require(:adjust_point).permit(:creditcard_num)
    end
end
