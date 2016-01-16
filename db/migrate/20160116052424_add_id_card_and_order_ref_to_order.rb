class AddIdCardAndOrderRefToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :id_card, :string
    add_column :orders, :ref, :string

    add_index :orders, :ref
  end
end
