class AddGuestTokenIndexToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_orders, :guest_token
  end
end
