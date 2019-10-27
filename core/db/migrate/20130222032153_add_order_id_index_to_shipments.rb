class AddOrderIdIndexToShipments < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_shipments, :order_id
  end
end
