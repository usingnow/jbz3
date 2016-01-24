class AddAdjustPointToRequestDynamicPassword < ActiveRecord::Migration
  def change
    add_reference :request_dynamic_passwords, :adjust_point, index: true, foreign_key: true
  end
end
