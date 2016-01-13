class RemoveEmailIndexFromUsers < ActiveRecord::Migration
  
  # 去除 devise 自动生成的 email 的 index 属性，即允许 email 重复
  def change
  	remove_index :users, column: :email
  end
end
