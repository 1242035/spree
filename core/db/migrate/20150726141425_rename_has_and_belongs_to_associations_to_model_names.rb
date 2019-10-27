class RenameHasAndBelongsToAssociationsToModelNames < ActiveRecord::Migration[4.2]
  def change
    {
      'viauco_option_types_prototypes' => 'viauco_option_type_prototypes',
      'viauco_option_values_variants' => 'viauco_option_value_variants',
      'viauco_orders_promotions' => 'viauco_order_promotions',
      'viauco_products_promotion_rules' => 'viauco_product_promotion_rules',
      'viauco_taxons_promotion_rules' => 'viauco_promotion_rule_taxons',
      'viauco_promotion_rules_users' => 'viauco_promotion_rule_users',
      'viauco_properties_prototypes' => 'viauco_property_prototypes',
      'viauco_taxons_prototypes' => 'viauco_prototype_taxons',
      'viauco_roles_users' => 'viauco_role_users',
      'viauco_shipping_methods_zones' => 'viauco_shipping_method_zones'
    }.each do |old_name, new_name|
      rename_table old_name, new_name
    end
  end
end
