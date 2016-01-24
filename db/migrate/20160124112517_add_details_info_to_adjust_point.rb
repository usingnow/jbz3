class AddDetailsInfoToAdjustPoint < ActiveRecord::Migration
  def change
    add_column :adjust_points, :card_no,                                :string
    add_column :adjust_points, :account_aggregate_integral,             :string
    add_column :adjust_points, :account_aggregate_integral_symbol,      :string
    add_column :adjust_points, :account_convertibility_integral,        :string
    add_column :adjust_points, :account_convertibility_integral_symbol, :string
    add_column :adjust_points, :current_change_integral,                :string
    add_column :adjust_points, :current_change_integral_symbol,         :string
    add_column :adjust_points, :current_new_integral,                   :string
    add_column :adjust_points, :current_new_integral_symbol,            :string
    add_column :adjust_points, :adjust_integral,                        :string
    add_column :adjust_points, :adjust_integral_sign,                   :string
    add_column :adjust_points, :integral_freezing_mark,                 :string
    add_column :adjust_points, :integral_freezing_date,                 :string
    add_column :adjust_points, :name,                                   :string
    add_column :adjust_points, :bonus_point,                            :string
    add_column :adjust_points, :bonus_point_symbol,                     :string
    add_column :adjust_points, :into_integral,                          :string
    add_column :adjust_points, :into_integral_sign,                     :string
    add_column :adjust_points, :roll_out_integral,                      :string
    add_column :adjust_points, :roll_out_integral_symbol,               :string
    add_column :adjust_points, :mileage_convertible_cap,                :string
    add_column :adjust_points, :already_for_mileage,                    :string
    add_column :adjust_points, :available_integral,                     :string
    add_column :adjust_points, :available_integral_symbol,              :string
    add_column :adjust_points, :status,                                 :string
  end
end
