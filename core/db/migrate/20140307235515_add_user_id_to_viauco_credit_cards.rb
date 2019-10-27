class AddUserIdToViaucoCreditCards < ActiveRecord::Migration[4.2]
  def change
    unless Viauco::CreditCard.column_names.include? "user_id"
      add_column :viauco_credit_cards, :user_id, :integer
      add_index :viauco_credit_cards, :user_id
    end

    unless Viauco::CreditCard.column_names.include? "payment_method_id"
      add_column :viauco_credit_cards, :payment_method_id, :integer
      add_index :viauco_credit_cards, :payment_method_id
    end
  end
end
