class AddStockLocationIdToViaucoShipments < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_shipments, :stock_location_id, :integer
  end
end
