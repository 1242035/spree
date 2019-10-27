class RenameReturnAuthorizationInventoryUnitToReturnItems < ActiveRecord::Migration[4.2]
  def change
    rename_table :viauco_return_authorization_inventory_units, :viauco_return_items
  end
end
