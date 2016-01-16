class Wechat::UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:login_by_SMS]
  before_action :set_user, only: [:show, :update, :destroy, :edit]

  layout 'wechat'

  def login_by_SMS

  end

  # 用户中心首页
  def user_center
    @orders = current_user.orders
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email)
    end

end