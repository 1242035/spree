class CreateShippingMethodCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :viauco_shipping_method_categories do |t|
      t.integer :shipping_method_id, null: false
      t.integer :shipping_category_id, null: false

      t.timestamps null: false, precision: 6
    end

    add_index :viauco_shipping_method_categories, :shipping_method_id
    add_index :viauco_shipping_method_categories, :shipping_category_id
  end
end
