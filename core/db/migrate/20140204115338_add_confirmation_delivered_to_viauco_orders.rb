class AddConfirmationDeliveredToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :confirmation_delivered, :boolean, default: false
  end
end
