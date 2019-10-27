class RemoveShippingCategoryIdFromShippingMethod < ActiveRecord::Migration[4.2]
  def change
    remove_column :viauco_shipping_methods, :shipping_category_id
  end
end
