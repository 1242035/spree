class AddPositionToTaxonomies < ActiveRecord::Migration[4.2]
  def change
  	add_column :viauco_taxonomies, :position, :integer, default: 0
  end
end
