class AddUserIdIndexToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_orders, :user_id
  end
end
