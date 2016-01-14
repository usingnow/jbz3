class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.string :name
      t.string :credicard_num
      t.string :email
      t.string :cellphone
      t.string :address

      t.timestamps null: false
    end
  end
end
