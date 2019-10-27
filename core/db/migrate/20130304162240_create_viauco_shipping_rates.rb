class CreateViaucoShippingRates < ActiveRecord::Migration[4.2]
  def up
    create_table :viauco_shipping_rates do |t|
      t.belongs_to :shipment
      t.belongs_to :shipping_method
      t.boolean :selected, default: false
      t.decimal :cost, precision: 8, scale: 2
      t.timestamps null: false, precision: 6
    end
    add_index(:viauco_shipping_rates, [:shipment_id, :shipping_method_id],
              name: 'viauco_shipping_rates_join_index',
              unique: true)

    # Viauco::Shipment.all.each do |shipment|
    #   shipping_method = Viauco::ShippingMethod.find(shipment.shipment_method_id)
    #   shipment.add_shipping_method(shipping_method, true)
    # end
  end

  def down
    # add_column :viauco_shipments, :shipping_method_id, :integer
    drop_table :viauco_shipping_rates
  end
end
