class AddTrackingUrlToViaucoShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_shipping_methods, :tracking_url, :string
  end
end
