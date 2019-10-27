class RemoveNotNullConstraintFromProductsOnHand < ActiveRecord::Migration[4.2]
  def up
    change_column :viauco_products, :count_on_hand, :integer, null: true
    change_column :viauco_variants, :count_on_hand, :integer, null: true
  end

  def down
    change_column :viauco_products, :count_on_hand, :integer, null: false
    change_column :viauco_variants, :count_on_hand, :integer, null: false
  end
end
