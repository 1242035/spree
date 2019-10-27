class RenameActivatorIdInRulesAndActionsToPromotionId < ActiveRecord::Migration[4.2]
  def change
    rename_column :viauco_promotion_rules, :activator_id, :promotion_id
    rename_column :viauco_promotion_actions, :activator_id, :promotion_id
  end
end
