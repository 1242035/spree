class AddDeletedAtToViaucoCreditCards < ActiveRecord::Migration[5.2]
  def change
    add_column :viauco_credit_cards, :deleted_at, :datetime
    add_index :viauco_credit_cards, :deleted_at
  end
end
