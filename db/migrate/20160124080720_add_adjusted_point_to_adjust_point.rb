class AddAdjustedPointToAdjustPoint < ActiveRecord::Migration
  def change
    add_column :adjust_points, :adjusted_point, :integer
  end
end
