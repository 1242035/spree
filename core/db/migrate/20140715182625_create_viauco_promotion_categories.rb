class CreateViaucoPromotionCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :viauco_promotion_categories do |t|
      t.string :name
      t.timestamps null: false, precision: 6
    end

    add_column :viauco_promotions, :promotion_category_id, :integer
    add_index :viauco_promotions, :promotion_category_id
  end
end
