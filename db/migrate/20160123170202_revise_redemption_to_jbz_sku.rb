class ReviseRedemptionToJbzSku < ActiveRecord::Migration
  def change
    change_column :jbz_skus, :redemption, :integer
  end
end
