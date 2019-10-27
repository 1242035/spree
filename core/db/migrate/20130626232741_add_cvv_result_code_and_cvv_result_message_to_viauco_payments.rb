class AddCvvResultCodeAndCvvResultMessageToViaucoPayments < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_payments, :cvv_response_code, :string
    add_column :viauco_payments, :cvv_response_message, :string
  end
end
