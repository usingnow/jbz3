class Wechat::UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:login_by_SMS]
  before_action :set_user, only: [:show, :update, :destroy, :edit]

  layout 'wechat'

  def login_by_SMS

  end

  # 用户中心首页
  def user_center
    @orders = current_user.orders
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to wechat_user_center_path
    else
      render 'user_center'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email)
    end

    def user_params
      params.require(:user).permit(:name, :cellphone, :creditcard_num, :id_card, :address, :email)
    end

end