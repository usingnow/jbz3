class AddInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :creditcard_num, :string
  	add_column :users, :address, :string
  	add_column :users, :id_card, :string
  end
end
