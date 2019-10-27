class AddDefaultToViaucoStockLocations < ActiveRecord::Migration[4.2]
  def change
    unless column_exists? :viauco_stock_locations, :default
      add_column :viauco_stock_locations, :default, :boolean, null: false, default: false
    end
  end
end
