class AddOnDemandToProductAndVariant < ActiveRecord::Migration[4.2]
  def change
  	add_column :viauco_products, :on_demand, :boolean, default: false
  	add_column :viauco_variants, :on_demand, :boolean, default: false
  end
end
