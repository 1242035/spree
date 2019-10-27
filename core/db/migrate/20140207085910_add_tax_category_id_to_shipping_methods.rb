class AddTaxCategoryIdToShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_shipping_methods, :tax_category_id, :integer
  end
end
