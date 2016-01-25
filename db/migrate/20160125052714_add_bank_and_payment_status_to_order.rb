class AddBankAndPaymentStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :bank, :string
    add_column :orders, :debitcard_num, :string
    add_column :orders, :if_paid, :boolean
  end
end
