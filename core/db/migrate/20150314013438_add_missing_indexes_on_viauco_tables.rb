class AddMissingIndexesOnViaucoTables < ActiveRecord::Migration[4.2]
  def change
    if data_source_exists?(:viauco_promotion_rules_users) && !index_exists?(:viauco_promotion_rules_users,
                                                                     [:user_id, :promotion_rule_id],
                                                                     name: 'index_promotion_rules_users_on_user_id_and_promotion_rule_id')
      add_index :viauco_promotion_rules_users,
                [:user_id, :promotion_rule_id],
                name: 'index_promotion_rules_users_on_user_id_and_promotion_rule_id'
    end

    if data_source_exists?(:viauco_products_promotion_rules) && !index_exists?(:viauco_products_promotion_rules,
                                                                        [:promotion_rule_id, :product_id],
                                                                        name: 'index_products_promotion_rules_on_promotion_rule_and_product')
      add_index :viauco_products_promotion_rules,
                [:promotion_rule_id, :product_id],
                name: 'index_products_promotion_rules_on_promotion_rule_and_product'
    end

    unless index_exists? :viauco_orders, :canceler_id
      add_index :viauco_orders, :canceler_id
    end

    unless index_exists? :viauco_orders, :store_id
      add_index :viauco_orders, :store_id
    end

    if data_source_exists?(:viauco_orders_promotions) && !index_exists?(:viauco_orders_promotions, [:promotion_id, :order_id])
      add_index :viauco_orders_promotions, [:promotion_id, :order_id]
    end

    if data_source_exists?(:viauco_properties_prototypes) && !index_exists?(:viauco_properties_prototypes, :prototype_id)
      add_index :viauco_properties_prototypes, :prototype_id
    end

    if data_source_exists?(:viauco_properties_prototypes) && !index_exists?(:viauco_properties_prototypes,
                                                                     [:prototype_id, :property_id],
                                                                     name: 'index_properties_prototypes_on_prototype_and_property')
      add_index :viauco_properties_prototypes,
                [:prototype_id, :property_id],
                name: 'index_properties_prototypes_on_prototype_and_property'
    end

    if data_source_exists?(:viauco_taxons_prototypes) && !index_exists?(:viauco_taxons_prototypes, [:prototype_id, :taxon_id])
      add_index :viauco_taxons_prototypes, [:prototype_id, :taxon_id]
    end

    if data_source_exists?(:viauco_option_types_prototypes) && !index_exists?(:viauco_option_types_prototypes, :prototype_id)
      add_index :viauco_option_types_prototypes, :prototype_id
    end

    if data_source_exists?(:viauco_option_types_prototypes) && !index_exists?(:viauco_option_types_prototypes,
                                                                       [:prototype_id, :option_type_id],
                                                                       name: 'index_option_types_prototypes_on_prototype_and_option_type')
      add_index :viauco_option_types_prototypes,
                [:prototype_id, :option_type_id],
                name: 'index_option_types_prototypes_on_prototype_and_option_type'
    end

    if data_source_exists?(:viauco_option_values_variants) && !index_exists?(:viauco_option_values_variants,
                                                                       [:option_value_id, :variant_id],
                                                                       name: 'index_option_values_variants_on_option_value_and_variant')
      add_index :viauco_option_values_variants,
                [:option_value_id, :variant_id],
                name: 'index_option_values_variants_on_option_value_and_variant'
    end
  end
end
