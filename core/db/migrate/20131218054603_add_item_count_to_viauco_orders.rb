class AddItemCountToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :item_count, :integer, default: 0
  end
end
