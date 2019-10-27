class CreateViaucoOrdersPromotions < ActiveRecord::Migration[4.2]
  def change
    create_table :viauco_orders_promotions, id: false do |t|
      t.references :order
      t.references :promotion
    end
  end
end
