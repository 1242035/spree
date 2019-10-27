class AddNameToViaucoCreditCards < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_credit_cards, :name, :string
  end
end
