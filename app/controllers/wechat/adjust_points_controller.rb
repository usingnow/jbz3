class Wechat::AdjustPointsController < ApplicationController
  layout 'wechat'

  before_action :set_adjust_point, only: [:show]

  def new
    @adjust_point = AdjustPoint.new
    @order = Order.find(session[:order_id])
  end

  def create
    @adjust_point = AdjustPoint.new(adjust_point_params)

    request_dynamic_password = RequestDynamicPassword.new(order_id: session[:order_id])

    @adjust_point.request_dynamic_passwords << request_dynamic_password

    request_dynamic_password.process_spdb_api(@adjust_point.creditcard_num,
                                              request_dynamic_password.create_rand_key)

    respond_to do |format|
      if @adjust_point.save
        format.html { redirect_to adjust_points_for_wechat_order_path(session[:order_id]), notice: '请确认以下信息。' }
      else
        format.html { redirect_to wechat_user_center_url, alert: "暂时无法扣除积分。请稍后尝试，或者联系管理员。" }
      end
    end
  end

  private
    def set_adjust_point
      @adjust_point = AdjustPoint.find(params[:id])
    end

    def adjust_point_params
      params.require(:adjust_point).permit(:creditcard_num, :adjusted_point)
    end
end
