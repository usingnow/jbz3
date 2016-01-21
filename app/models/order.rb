class Order < ActiveRecord::Base
  belongs_to :user
  has_one :adjust_point
  has_many :query_points
  has_many :line_items, dependent: :destroy

  validates :name, :creditcard_num, :id_card, :cellphone, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  private
    def self.create_ref
      'jbz' + DateTime.current.to_formatted_s(:number) + Random.rand(0..999).to_s
    end
end
