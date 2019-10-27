class ChangeOrdersTotalPrecision < ActiveRecord::Migration[4.2]
   def change
    change_column :viauco_orders, :item_total,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
    change_column :viauco_orders, :total,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
    change_column :viauco_orders, :adjustment_total,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
    change_column :viauco_orders, :payment_total,  :decimal, precision: 10, scale: 2, default: 0.0                                
   end
end
