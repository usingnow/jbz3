class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :jbz_sku
  belongs_to :cart

  def total_price
    jbz_sku.price * quantity
  end

  def total_reward
    jbz_sku.reward * quantity
  end
end
