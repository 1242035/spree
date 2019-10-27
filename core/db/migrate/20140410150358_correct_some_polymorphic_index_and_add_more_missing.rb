class CorrectSomePolymorphicIndexAndAddMoreMissing < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_addresses, :country_id
    add_index :viauco_addresses, :state_id
    remove_index :viauco_adjustments, [:source_type, :source_id]
    add_index :viauco_adjustments, [:source_id, :source_type]
    add_index :viauco_credit_cards, :address_id
    add_index :viauco_gateways, :active
    add_index :viauco_gateways, :test_mode
    add_index :viauco_inventory_units, :return_authorization_id
    add_index :viauco_line_items, :tax_category_id
    add_index :viauco_log_entries, [:source_id, :source_type]
    add_index :viauco_orders, :approver_id
    add_index :viauco_orders, :bill_address_id
    add_index :viauco_orders, :confirmation_delivered
    add_index :viauco_orders, :considered_risky
    add_index :viauco_orders, :created_by_id
    add_index :viauco_orders, :ship_address_id
    add_index :viauco_orders, :shipping_method_id
    add_index :viauco_orders_promotions, [:order_id, :promotion_id]
    add_index :viauco_payments, [:source_id, :source_type]
    add_index :viauco_prices, :deleted_at
    add_index :viauco_product_option_types, :position
    add_index :viauco_product_properties, :position
    add_index :viauco_product_properties, :property_id
    add_index :viauco_products, :shipping_category_id
    add_index :viauco_products, :tax_category_id
    add_index :viauco_promotion_action_line_items, :promotion_action_id
    add_index :viauco_promotion_action_line_items, :variant_id
    add_index :viauco_promotion_rules, :promotion_id
    add_index :viauco_promotions, :advertise
    add_index :viauco_return_authorizations, :number
    add_index :viauco_return_authorizations, :order_id
    add_index :viauco_return_authorizations, :stock_location_id
    add_index :viauco_shipments, :address_id
    add_index :viauco_shipping_methods, :deleted_at
    add_index :viauco_shipping_methods, :tax_category_id
    add_index :viauco_shipping_rates, :selected
    add_index :viauco_shipping_rates, :tax_rate_id
    add_index :viauco_state_changes, [:stateful_id, :stateful_type]
    add_index :viauco_state_changes, :user_id
    add_index :viauco_stock_items, :backorderable
    add_index :viauco_stock_locations, :active
    add_index :viauco_stock_locations, :backorderable_default
    add_index :viauco_stock_locations, :country_id
    add_index :viauco_stock_locations, :propagate_all_variants
    add_index :viauco_stock_locations, :state_id
    add_index :viauco_tax_categories, :deleted_at
    add_index :viauco_tax_categories, :is_default
    add_index :viauco_tax_rates, :deleted_at
    add_index :viauco_tax_rates, :included_in_price
    add_index :viauco_tax_rates, :show_rate_in_label
    add_index :viauco_tax_rates, :tax_category_id
    add_index :viauco_tax_rates, :zone_id
    add_index :viauco_taxonomies, :position
    add_index :viauco_taxons, :position
    add_index :viauco_trackers, :active
    add_index :viauco_variants, :deleted_at
    add_index :viauco_variants, :is_master
    add_index :viauco_variants, :position
    add_index :viauco_variants, :track_inventory
    add_index :viauco_zone_members, :zone_id
    add_index :viauco_zone_members, [:zoneable_id, :zoneable_type]
    add_index :viauco_zones, :default_tax
  end
end
