class DropProductsCountOnHand < ActiveRecord::Migration[4.2]
  def up
    remove_column :viauco_products, :count_on_hand
  end
end
