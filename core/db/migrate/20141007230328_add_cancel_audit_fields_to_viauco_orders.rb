class AddCancelAuditFieldsToViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :canceled_at, :datetime
    add_column :viauco_orders, :canceler_id, :integer
  end
end
