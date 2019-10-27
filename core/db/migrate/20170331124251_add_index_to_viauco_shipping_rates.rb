class AddIndexToViaucoShippingRates < ActiveRecord::Migration[5.0]
  def change
    add_index :viauco_shipping_rates, :shipment_id
    add_index :viauco_shipping_rates, :shipping_method_id
  end
end
