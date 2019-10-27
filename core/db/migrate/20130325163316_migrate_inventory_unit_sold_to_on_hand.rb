class MigrateInventoryUnitSoldToOnHand < ActiveRecord::Migration[4.2]
  def up
    Viauco::InventoryUnit.where(state: 'sold').update_all(state: 'on_hand')
  end

  def down
    Viauco::InventoryUnit.where(state: 'on_hand').update_all(state: 'sold')
  end
end
