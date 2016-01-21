class CreateRequestDynamicPasswords < ActiveRecord::Migration
  def change
    create_table :request_dynamic_passwords do |t|
      t.string :creditcard_num
      t.text :request
      t.text :response

      t.timestamps null: false
    end
    
    add_reference :request_dynamic_passwords, :user, index: true, foreign_key: true
  end
end
