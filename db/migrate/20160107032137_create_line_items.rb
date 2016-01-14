class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|

      t.integer :jbz_sku_id
      t.integer :cart_id

      t.timestamps null: false
    end

    add_index :line_items, :jbz_sku_id
    add_index :line_items, :cart_id
  end
end