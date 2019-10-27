class AddStoreIdToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_orders, :store_id, :integer
    if Viauco::Store.default.persisted?
      Viauco::Order.where(store_id: nil).update_all(store_id: Viauco::Store.default.id)
    end
  end
end
