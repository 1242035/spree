class IndexCompletedAtOnViaucoOrders < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_orders, :completed_at
  end
end
