class AddApproverIdAndApprovedAtToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :approver_id, :integer
    add_column :viauco_orders, :approved_at, :datetime
  end
end
