class AddCodeToViaucoShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_shipping_methods, :code, :string
  end
end
