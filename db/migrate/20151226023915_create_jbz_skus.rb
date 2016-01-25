class CreateJbzSkus < ActiveRecord::Migration
  def change
    create_table :jbz_skus do |t|

      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.decimal :original_price, precision: 8, scale: 2
      t.integer :reward
      t.integer :sales_volume
      t.integer :product_id
      t.string :ref

      t.integer  :redemption

      t.timestamps null: false
    end

    add_index :jbz_skus, :product_id
    add_index :jbz_skus, :ref
  end
end
