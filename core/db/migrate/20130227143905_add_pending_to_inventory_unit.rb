class AddPendingToInventoryUnit < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_inventory_units, :pending, :boolean, default: true
    Viauco::InventoryUnit.update_all(pending: false)
  end
end
