class Users::SessionsController < Devise::SessionsController
  layout 'wechat'
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @user = User.find(session[:user_id])
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # 删除不需要的session
  #   session[:dynamic_password] =nil
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
