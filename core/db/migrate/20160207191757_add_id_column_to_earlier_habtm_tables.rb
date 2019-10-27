class AddIdColumnToEarlierHabtmTables < ActiveRecord::Migration[4.2]
  def up
    add_column :viauco_option_type_prototypes, :id, :primary_key
    add_column :viauco_option_value_variants, :id, :primary_key
    add_column :viauco_order_promotions, :id, :primary_key
    add_column :viauco_product_promotion_rules, :id, :primary_key
    add_column :viauco_promotion_rule_users, :id, :primary_key
    add_column :viauco_property_prototypes, :id, :primary_key
    add_column :viauco_role_users, :id, :primary_key
    add_column :viauco_shipping_method_zones, :id, :primary_key
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
