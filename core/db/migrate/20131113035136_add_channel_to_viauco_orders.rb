class AddChannelToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :channel, :string, default: "viauco"
  end
end
