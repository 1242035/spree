class UpdateShipmentStateForCanceledOrders < ActiveRecord::Migration[4.2]
  def up
    shipments = Viauco::Shipment.joins(:order).
      where("viauco_orders.state = 'canceled'")
    case Viauco::Shipment.connection.adapter_name
    when "SQLite3"
      shipments.update_all("state = 'cancelled'")
    when "MySQL" || "PostgreSQL"
      shipments.update_all("viauco_shipments.state = 'cancelled'")
    end
  end

  def down
  end
end
