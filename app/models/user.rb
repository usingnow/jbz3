class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login

  devise :database_authenticatable, :registerable,:recoverable,
         :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  
  validates :cellphone, format: { with: /1(3\d|5[^4]|8[056789])\d{8}/, message: "手机号不正确，请重新输入" }

  # 取消 devise 默认 email 必须有值
  def email_required?
    false
  end

  # 允许使用 cellphone 或 email 登录
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["cellphone = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end
end



