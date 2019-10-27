class SetDefaultStockLocationOnShipments < ActiveRecord::Migration[4.2]
  def change
    if Viauco::Shipment.where('stock_location_id IS NULL').count > 0
      location = Viauco::StockLocation.find_by(name: 'default') || Viauco::StockLocation.first
      Viauco::Shipment.where('stock_location_id IS NULL').update_all(stock_location_id: location.id)
    end
  end
end
