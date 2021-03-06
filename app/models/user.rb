class User < ActiveRecord::Base
  has_many :orders
  has_many :adjust_points
  has_many :query_points
  has_many :request_dynamic_passwords

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login

  devise :database_authenticatable, :registerable,:recoverable,
         :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  
  validates_presence_of :cellphone, :creditcard_num
  validates_uniqueness_of :cellphone, :creditcard_num
  validates :cellphone, format: { with: /1(3\d|5[^4]|8[^34])\d{8}/, message: "手机号不正确，请重新输入" }, length: { is: 11 }
  validates_length_of :creditcard_num, is: 16, message: "浦发信用卡号不正确，请重新输入"

  # update 时需要验证的字段
  validates :id_card, format: { with: /([1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3})|([1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4})/, message: "身份证号不正确，请重新输入" }, on: :update
  validates_length_of :id_card, maximum: 18, on: :update
  validates_presence_of :id_card, :name, on: :update
  

  # 取消 devise 默认 email 必须有值
  def email_required?
    false
  end

  # 允许使用 cellphone 或 email 登录
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["cellphone = :value OR creditcard_num = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # 调用浦发 API 发送验证码
  def request_dynamic_pd
    request_dynamic_password = RequestDynamicPassword.new
    request_dynamic_passwords << request_dynamic_password

    request_dynamic_password.dynamic_key = request_dynamic_password.process_spdb_api(request_dynamic_password.user.creditcard_num, create_rand_key)
    if request_dynamic_password.dynamic_key
      request_dynamic_password.save
      return request_dynamic_password.dynamic_key
    else
      logger.error "验证码发送失败"
      return
    end
  end

end



