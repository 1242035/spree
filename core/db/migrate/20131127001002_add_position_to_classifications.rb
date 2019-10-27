class AddPositionToClassifications < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_products_taxons, :position, :integer
  end
end
