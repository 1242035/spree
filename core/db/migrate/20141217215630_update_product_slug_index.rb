class UpdateProductSlugIndex < ActiveRecord::Migration[4.2]
  def change
    remove_index :viauco_products, :slug if index_exists?(:viauco_products, :slug)
    add_index :viauco_products, :slug, unique: true
  end
end
