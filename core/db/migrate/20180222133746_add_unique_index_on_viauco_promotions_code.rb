class AddUniqueIndexOnViaucoPromotionsCode < ActiveRecord::Migration[5.1]
  def change
    remove_index :viauco_promotions, :code
    add_index :viauco_promotions, :code, unique: true
  end
end
