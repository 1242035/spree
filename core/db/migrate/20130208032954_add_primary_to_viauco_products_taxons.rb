class AddPrimaryToViaucoProductsTaxons < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_products_taxons, :id, :primary_key
  end
end
