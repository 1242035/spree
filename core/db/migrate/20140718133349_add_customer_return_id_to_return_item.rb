class AddCustomerReturnIdToReturnItem < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_return_items, :customer_return_id, :integer
    add_index :viauco_return_items, :customer_return_id, name: 'index_return_items_on_customer_return_id'
  end
end
