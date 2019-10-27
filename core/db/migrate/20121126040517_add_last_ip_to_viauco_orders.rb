class AddLastIpToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :last_ip_address, :string
  end
end
