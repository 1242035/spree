class RemoveUncapturedAmountFromViaucoPayments < ActiveRecord::Migration[4.2]
  def change
    remove_column :viauco_payments, :uncaptured_amount
  end
end
