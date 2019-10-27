class AddTaxableAdjustmentTotalToLineItem < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_line_items, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :viauco_line_items, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false

    add_column :viauco_shipments, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :viauco_shipments, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false

    add_column :viauco_orders, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :viauco_orders, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    # TODO migration that updates old orders
  end
end
