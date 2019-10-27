class AddIndexToShippingMethodCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :viauco_shipping_method_categories, :shipping_category_id
  end
end
