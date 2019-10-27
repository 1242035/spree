class AddUniqueIndexOnNumberToViaucoShipment < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:viauco_shipments, :number, unique: true)
      numbers = Viauco::Shipment.group(:number).having('sum(1) > 1').pluck(:number)
      shipments = Viauco::Shipment.where(number: numbers)

      shipments.find_each do |shipment|
        shipment.number = shipment.class.number_generator.method(:generate_permalink).call(shipment.class)
        shipment.save
      end

      remove_index :viauco_shipments, :number if index_exists?(:viauco_shipments, :number)
      add_index :viauco_shipments, :number, unique: true
    end
  end
end
