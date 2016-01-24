class AddOrderAndStatusToRequestDynamicPassword < ActiveRecord::Migration
  def change
    add_column :request_dynamic_passwords, :status, :string

    add_reference :request_dynamic_passwords, :order, index: true, foreign_key: true
  end
end
