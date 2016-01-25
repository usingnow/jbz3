class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if resource.class.to_s == "User"
      root_path(resource.id)
    else
      root_path
    end
  end

  # def after_sign_up_path_for(resource)
  #   # if resource.class.to_s == "User"
  #   edit_wechat_user_path(resource)
  #   # else
  #   #   root_path
  #   # end
  # end

  # 用户登出后的界面，默认是 root_path，暂不需要改动，以下代码留作将来使用
  # def after_sign_out_path_for(resource)
  #   if resource == :user
  #     wechat_user_center_path
  #   else
  #     root_path
  #   end
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :cellphone, :creditcard_num, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :cellphone, :creditcard_num, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:cellphone, :creditcard_num, :email, :password, :password_confirmation, :current_password) }
  end

end
