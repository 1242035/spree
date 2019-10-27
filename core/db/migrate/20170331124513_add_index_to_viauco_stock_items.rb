class AddIndexToViaucoStockItems < ActiveRecord::Migration[5.0]
  def change
    add_index :viauco_stock_items, :stock_location_id
  end
end
