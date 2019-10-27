class AddCreatedByIdToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :created_by_id, :integer
  end
end
