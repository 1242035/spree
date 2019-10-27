class AddQuantityToInventoryUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :viauco_inventory_units, :quantity, :integer, default: 1
  end
end
