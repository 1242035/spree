class RemoveDuplicatedIndexesFromMultiColumns < ActiveRecord::Migration[4.2]
  def change
    remove_index :viauco_adjustments, name: "index_adjustments_on_order_id"
    remove_index :viauco_option_types_prototypes, :prototype_id
    add_index :viauco_option_types_prototypes, :option_type_id
    remove_index :viauco_option_values_variants, name: 'index_option_values_variants_on_option_value_and_variant'
    remove_index :viauco_option_values_variants, :variant_id
    add_index :viauco_option_values_variants, :option_value_id
    remove_index :viauco_orders, :user_id
    remove_index :viauco_orders_promotions, [:order_id, :promotion_id]
    add_index :viauco_orders_promotions, :order_id
    remove_index :viauco_products_promotion_rules, name: "index_products_promotion_rules_on_promotion_rule_id"
    remove_index :viauco_promotion_rules_users, name: "index_promotion_rules_users_on_user_id"
    remove_index :viauco_properties_prototypes, :prototype_id
    remove_index :viauco_stock_items, :stock_location_id
    remove_index :viauco_taxons_prototypes, :prototype_id
  end
end
