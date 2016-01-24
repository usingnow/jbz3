class Wechat::UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:login_by_sms, :create]
  before_action :set_user, only: [:show, :update, :destroy, :edit]

  layout 'wechat'

  # 用户中心首页
  def user_center
    @orders = current_user.orders
    @user = current_user
  end

  def update
    # @user = User.find(params[:id])                已经:set_user了，这行应该没用，保险起见，暂且先注释
    if @user.update(user_params)
      redirect_to wechat_user_center_path
    else
      render 'user_center'
    end

    #   if @user.update(user_params)
    #     return
    #   else
    #   format.html { render action: 'user_center' }
    #   format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
  end

  def login_by_sms
    @user = User.new
  end
  
  # 利用 simple_form 的 submit 来响应后台验证码的生成发送功能
  def create
    @user = User.find_by(params[:creditcard_num])
    session[:dynamic_key] = @user.request_dynamic_pd

    if @user.request_dynamic_pd
      redirect_to new_user_session_path
    else
      redirect_to wechat_users_login_by_sms_path
    end

  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :cellphone, :creditcard_num, :id_card, :address, :email)
    end

end