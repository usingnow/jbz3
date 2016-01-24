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

  # Todo: 这里使用了默认的 simple_for submit 方法，会浪费资源，等下一次迭代重构
  def login_by_sms
    @user = User.new
  end
  
  # 利用 simple_form 的 submit 来响应后台验证码的生成发送功能
  def create
    if @user = User.find_by_creditcard_num(params[:user][:creditcard_num])
      if @user.request_dynamic_pd
        session[:user_id] = @user.id
        redirect_to new_user_session_path
      else
        redirect_to wechat_users_login_by_sms_path
      end

    else
      # flash[:alert] = "对不起，请注册后再登录，谢谢！"
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