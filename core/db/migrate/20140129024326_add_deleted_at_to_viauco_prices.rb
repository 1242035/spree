class AddDeletedAtToViaucoPrices < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_prices, :deleted_at, :datetime
  end
end
