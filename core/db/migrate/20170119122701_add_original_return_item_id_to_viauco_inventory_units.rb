class AddOriginalReturnItemIdToViaucoInventoryUnits < ActiveRecord::Migration[5.0]
  def up
    add_reference :viauco_inventory_units, :original_return_item, references: :viauco_return_items, index: true

    Viauco::InventoryUnit.reset_column_information

    Viauco::ReturnItem.where.not(exchange_inventory_unit_id: nil).find_each do |return_item|
      if (inventory_unit = Viauco::InventoryUnit.find_by(id: return_item.exchange_inventory_unit_id)).present?
        inventory_unit.update_column(:original_return_item_id, return_item.id)
      end
    end

    remove_column :viauco_return_items, :exchange_inventory_unit_id
  end

  def down
    add_reference :viauco_return_items, :exchange_inventory_unit, references: :viauco_inventory_units, index: true

    Viauco::InventoryUnit.reset_column_information

    Viauco::InventoryUnit.where.not(original_return_item_id: nil).find_each do |inventory_unit|
      if (return_item = Viauco::ReturnItem.find_by(id: inventory_unit.original_return_item_id)).present?
        return_item.update_column(:exchange_inventory_unit_id, inventory_unit.id)
      end
    end

    remove_reference :viauco_inventory_units, :original_return_item
  end
end
