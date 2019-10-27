class AddPreTaxAmountToLineItemsAndShipments < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_line_items, :pre_tax_amount, :decimal, precision: 8, scale: 2
    add_column :viauco_shipments, :pre_tax_amount, :decimal, precision: 8, scale: 2
  end
end
