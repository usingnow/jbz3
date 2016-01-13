class Wechat::UsersController < ApplicationController

  before_filter :authenticate_User!, except: [:login_by_SMS]

  layout 'wechat'

  def login_by_SMS

  end

end