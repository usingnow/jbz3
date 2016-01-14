class AddCellphoneToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :cellphone, :string
  end
end
