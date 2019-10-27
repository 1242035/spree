class AddPromoTotalToLineItemsAndShipmentsAndOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_line_items, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :viauco_shipments, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :viauco_orders, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
