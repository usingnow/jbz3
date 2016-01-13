class Wechat::UsersController < ApplicationController

  before_filter :authenticate_User!, except: [:login_by_SMS, :login_by_account]

  layout 'wechat'

  def login_by_SMS

  end

  def login_by_account
  	
  end

end