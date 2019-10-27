class AddPromotionableToViaucoProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_products, :promotionable, :boolean, default: true
  end
end
