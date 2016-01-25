class Order < ActiveRecord::Base
  belongs_to :user
  has_one :adjust_point
  has_many :query_points
  has_many :request_dynamic_passwords
  has_many :line_items, dependent: :destroy

  validates :name, :cellphone, :id_card, :creditcard_num, :debitcard_num, :bank, presence: true
  # validates :id_card, format: { with: /([1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3})|([1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4})/, message: "身份证号不正确，请重新输入" }
  validates :cellphone, format: { with: /1(3\d|5[^4]|8[^34])\d{8}/, message: "手机号不正确，请重新输入" }, length: { is: 11 }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def self.search(search)
    if search
      where(['id_card LIKE ?', "%#{search}%"]).order("id ASC")
    end
  end

  private
    def self.create_ref
      'jbz' + DateTime.current.to_formatted_s(:number) + Random.rand(0..999).to_s
    end
end
