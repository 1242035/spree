class RemoveShippingMethodIdFromViaucoOrders < ActiveRecord::Migration[4.2]
  def up
    if column_exists?(:viauco_orders, :shipping_method_id, :integer)
      remove_column :viauco_orders, :shipping_method_id, :integer
    end
  end

  def down
    unless column_exists?(:viauco_orders, :shipping_method_id, :integer)
      add_column :viauco_orders, :shipping_method_id, :integer
    end
  end
end
