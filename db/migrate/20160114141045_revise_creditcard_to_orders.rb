class ReviseCreditcardToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.rename :credicard_num, :creditcard_num
    end
  end
end
