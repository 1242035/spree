class AddIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_assets, :position
    add_index :viauco_option_types, :name
    add_index :viauco_option_values, :name
    add_index :viauco_prices, :variant_id
    add_index :viauco_properties, :name
    add_index :viauco_roles, :name
    add_index :viauco_shipping_categories, :name
    add_index :viauco_taxons, :lft
    add_index :viauco_taxons, :rgt
    add_index :viauco_taxons, :name
  end
end
