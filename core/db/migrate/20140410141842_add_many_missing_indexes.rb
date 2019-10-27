class AddManyMissingIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_adjustments, [:adjustable_id, :adjustable_type]
    add_index :viauco_adjustments, :eligible
    add_index :viauco_adjustments, :order_id
    add_index :viauco_promotions, :code
    add_index :viauco_promotions, :expires_at
    add_index :viauco_states, :country_id
    add_index :viauco_stock_items, :deleted_at
    add_index :viauco_option_types, :position
    add_index :viauco_option_values, :position
    add_index :viauco_product_option_types, :option_type_id
    add_index :viauco_product_option_types, :product_id
    add_index :viauco_products_taxons, :position
    add_index :viauco_promotions, :starts_at
    add_index :viauco_stores, :url
  end
end
