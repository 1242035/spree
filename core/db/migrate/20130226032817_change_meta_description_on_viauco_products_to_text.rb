class ChangeMetaDescriptionOnViaucoProductsToText < ActiveRecord::Migration[4.2]
  def change
    change_column :viauco_products, :meta_description, :text, limit: nil
  end
end
