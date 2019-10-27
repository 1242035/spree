class ChangeViaucoPriceAmountPrecision < ActiveRecord::Migration[4.2]
  def change
    change_column :viauco_prices, :amount,  :decimal, precision: 10, scale: 2
    change_column :viauco_line_items, :price,  :decimal, precision: 10, scale: 2
    change_column :viauco_line_items, :cost_price,  :decimal, precision: 10, scale: 2
    change_column :viauco_variants, :cost_price, :decimal, precision: 10, scale: 2
  end
end
