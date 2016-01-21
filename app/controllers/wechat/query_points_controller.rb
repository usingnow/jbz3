class Wechat::QueryPointsController < ApplicationController
  layout 'wechat'

  before_action :set_query_point, only: [:show]

  def new
    @query_point = QueryPoint.new
  end

  def create
    @query_point = QueryPoint.new(query_point_params)

    @query_point.request = @query_point.build_req(@query_point.creditcard_num)
    @query_point.order_id = session[:order_id]
    @query_point.user_id = current_user.id

    respond_to do |format|
      if @query_point.save
        format.html { redirect_to new_wechat_adjust_point_path, notice: '请确认以下信息。' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    def set_query_point
      @query_point = QueryPoint.find(params[:id])
    end

    def query_point_params
      params.require(:query_point).permit(:creditcard_num)
    end
end
