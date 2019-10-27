class AddAdminNameColumnToViaucoShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_shipping_methods, :admin_name, :string
  end
end
