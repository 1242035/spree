class RemoveNotNullFromViaucoPricesAmount < ActiveRecord::Migration[4.2]
  def up
    change_column :viauco_prices, :amount, :decimal, precision: 8, scale: 2, null: true
  end

  def down
    change_column :viauco_prices, :amount, :decimal, precision: 8, scale: 2, null: false
  end
end
