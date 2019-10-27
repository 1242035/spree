class RemoveUnusedCreditCardFields < ActiveRecord::Migration[4.2]
  def up
    remove_column :viauco_credit_cards, :start_month if column_exists?(:viauco_credit_cards, :start_month)
    remove_column :viauco_credit_cards, :start_year if column_exists?(:viauco_credit_cards, :start_year)
    remove_column :viauco_credit_cards, :issue_number if column_exists?(:viauco_credit_cards, :issue_number)
  end
  def down
    add_column :viauco_credit_cards, :start_month,  :string
    add_column :viauco_credit_cards, :start_year,   :string
    add_column :viauco_credit_cards, :issue_number, :string
  end

  def column_exists?(table, column)
    ApplicationRecord.connection.column_exists?(table, column)
  end
end
