class AddIndexesToViaucoOptionValueVariant < ActiveRecord::Migration[5.0]
  def change
    duplicates = Viauco::OptionValueVariant.group(:variant_id, :option_value_id).having('sum(1) > 1').size

    duplicates.each do |f|
      variant_id, option_value_id = f.first
      count = f.last - 1 # we want to leave one record
      ov = Viauco::OptionValueVariant.where(variant_id: variant_id, option_value_id: option_value_id).last(count)
      ov.map(&:destroy)
    end

    if index_exists? :viauco_option_value_variants, [:variant_id, :option_value_id], name: "index_option_values_variants_on_variant_id_and_option_value_id"
      remove_index :viauco_option_value_variants, [:variant_id, :option_value_id]
      add_index :viauco_option_value_variants, [:variant_id, :option_value_id], unique: true, name: "index_option_values_variants_on_variant_id_and_option_value_id"
    end

    add_index :viauco_option_value_variants, :variant_id
  end
end
