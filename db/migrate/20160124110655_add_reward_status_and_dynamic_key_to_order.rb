class AddRewardStatusAndDynamicKeyToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :if_reward_paid, :boolean
    add_column :orders, :dynamic_key, :string
  end
end
