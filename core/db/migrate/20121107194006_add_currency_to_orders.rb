class AddCurrencyToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :currency, :string
  end
end
