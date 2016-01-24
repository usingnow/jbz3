class AddDynamickeyIntoRequestDynamicPasswords < ActiveRecord::Migration
  def change
    add_column :request_dynamic_passwords, :dynamic_key, :string
  end
end
