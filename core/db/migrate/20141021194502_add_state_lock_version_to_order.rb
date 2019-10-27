class AddStateLockVersionToOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :state_lock_version, :integer, default: 0, null: false
  end
end
