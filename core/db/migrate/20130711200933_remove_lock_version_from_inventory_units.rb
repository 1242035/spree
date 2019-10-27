class RemoveLockVersionFromInventoryUnits < ActiveRecord::Migration[4.2]
  def change
    # we are moving to pessimistic locking on stock_items
    remove_column :viauco_inventory_units, :lock_version
  end
end
