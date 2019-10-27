class AddSkuIndexToViaucoVariants < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_variants, :sku
  end
end
