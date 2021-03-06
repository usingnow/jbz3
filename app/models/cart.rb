class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_jbz_sku(jbz_sku_id)
    current_item = line_items.find_by(jbz_sku_id: jbz_sku_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(jbz_sku_id: jbz_sku_id)
    end
    current_item
  end

  def total_amount
    line_items.to_a.sum { |item| item.total_price }
  end

  def total_reward
    line_items.to_a.sum { |item| item.total_reward }
  end
end
