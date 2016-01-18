class ChangeColumnDefaultValueInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :name, :string, default: "" 
  	change_column :users, :creditcard_num, :string, default: "" 
  	change_column :users, :address, :string, default: "" 
  	change_column :users, :id_card, :string, default: ""  
  end
end