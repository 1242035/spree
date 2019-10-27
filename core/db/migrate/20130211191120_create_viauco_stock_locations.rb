class CreateViaucoStockLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :viauco_stock_locations do |t|
      t.string :name
      t.belongs_to :address

      t.timestamps null: false, precision: 6
    end
    add_index :viauco_stock_locations, :address_id
  end
end
