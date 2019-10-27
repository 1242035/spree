class RemoveOnDemandFromProductAndVariant < ActiveRecord::Migration[4.2]
  def change
    remove_column :viauco_products, :on_demand
    remove_column :viauco_variants, :on_demand
  end
end
