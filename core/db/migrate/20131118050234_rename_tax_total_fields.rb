class RenameTaxTotalFields < ActiveRecord::Migration[4.2]
  def change
    rename_column :viauco_line_items, :tax_total, :additional_tax_total
    rename_column :viauco_shipments, :tax_total, :additional_tax_total
    rename_column :viauco_orders, :tax_total, :additional_tax_total

    add_column :viauco_line_items, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :viauco_shipments, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :viauco_orders, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
