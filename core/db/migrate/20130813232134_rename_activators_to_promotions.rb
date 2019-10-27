class RenameActivatorsToPromotions < ActiveRecord::Migration[4.2]
  def change
    rename_table :viauco_activators, :viauco_promotions
  end
end
