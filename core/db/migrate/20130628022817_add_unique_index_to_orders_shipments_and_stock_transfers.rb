class AddUniqueIndexToOrdersShipmentsAndStockTransfers < ActiveRecord::Migration[4.2]
  def add
    add_index "viauco_orders", ["number"], name: "number_idx_unique", unique: true
    add_index "viauco_shipments", ["number"], name: "number_idx_unique", unique: true
    add_index "viauco_stock_transfers", ["number"], name: "number_idx_unique", unique: true
  end
end
