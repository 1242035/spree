class AddTokenToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :guest_token, :string
  end
end
