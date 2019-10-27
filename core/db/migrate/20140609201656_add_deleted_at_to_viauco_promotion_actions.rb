class AddDeletedAtToViaucoPromotionActions < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_promotion_actions, :deleted_at, :datetime
    add_index :viauco_promotion_actions, :deleted_at
  end
end
