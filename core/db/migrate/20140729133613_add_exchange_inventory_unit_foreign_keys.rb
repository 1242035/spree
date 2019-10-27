class AddExchangeInventoryUnitForeignKeys < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_return_items, :exchange_inventory_unit_id, :integer

    add_index :viauco_return_items, :exchange_inventory_unit_id
  end
end
