class AddDefaultToViaucoCreditCards < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_credit_cards, :default, :boolean, null: false, default: false
  end
end
