class AddAdminNameColumnToViaucoStockLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_stock_locations, :admin_name, :string
  end
end
