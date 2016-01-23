class AddRedeemedAndWrittenOffDateToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :redeemed_at, :datetime
    add_column :line_items, :written_off_at, :datetime
  end
end
