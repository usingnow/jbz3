class AddTotalPriceAndRewardToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_amount, :decimal, precision: 5, scale: 2
    add_column :orders, :total_reward, :decimal, precision: 10, scale: 0
  end
end
