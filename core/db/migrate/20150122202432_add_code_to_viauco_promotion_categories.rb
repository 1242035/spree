class AddCodeToViaucoPromotionCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_promotion_categories, :code, :string
  end
end
