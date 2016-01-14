class AddChangeColumnNullToUserEmail < ActiveRecord::Migration
  # 允许 devise 自动生成的 email 字段为空
  def self.up
    change_column :users, :email, :string, :null => true 
  end

  def self.down
    change_column :users, :email, :string, :null => false 
  end
end