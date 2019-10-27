class AddIndexToShippingMethodZones < ActiveRecord::Migration[5.0]
  def change
    duplicates = Viauco::ShippingMethodZone.group(:shipping_method_id, :zone_id).having('sum(1) > 1').size

    duplicates.each do |f|
      shipping_method_id, zone_id = f.first
      count = f.last - 1 # we want to leave one record
      zones = Viauco::ShippingMethodZone.where(shipping_method_id: shipping_method_id, zone_id: zone_id).last(count)
      zones.map(&:destroy)
    end

    if index_exists? :viauco_shipping_method_zones, [:shipping_method_id, :zone_id]
      remove_index :viauco_shipping_method_zones, [:shipping_method_id, :zone_id]
      add_index :viauco_shipping_method_zones, [:shipping_method_id, :zone_id], unique: true
    end

    add_index :viauco_shipping_method_zones, :zone_id
    add_index :viauco_shipping_method_zones, :shipping_method_id
  end
end
