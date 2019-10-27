class AddActiveFieldToStockLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_stock_locations, :active, :boolean, default: true
  end
end
