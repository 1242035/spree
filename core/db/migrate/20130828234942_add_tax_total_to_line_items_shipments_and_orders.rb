class AddTaxTotalToLineItemsShipmentsAndOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_line_items, :tax_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :viauco_shipments, :tax_total, :decimal, precision: 10, scale: 2, default: 0.0
    # This column may already be here from a 2.1.x migration
    add_column :viauco_orders, :tax_total, :decimal, precision: 10, scale: 2, default: 0.0 unless column_exists? :viauco_orders, :tax_total, :decimal
  end
end
