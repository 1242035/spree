class AddDeletedAtToViaucoStockItems < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_stock_items, :deleted_at, :datetime
  end
end
