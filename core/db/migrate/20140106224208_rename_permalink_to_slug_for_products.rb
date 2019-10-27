class RenamePermalinkToSlugForProducts < ActiveRecord::Migration[4.2]
  def change
    rename_column :viauco_products, :permalink, :slug
  end
end
