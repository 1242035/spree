class AddIdentifierToViaucoPayments < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_payments, :identifier, :string
  end
end
