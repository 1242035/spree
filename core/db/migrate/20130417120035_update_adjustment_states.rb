class UpdateAdjustmentStates < ActiveRecord::Migration[4.2]
  def up
    Viauco::Order.complete.find_each do |order|
      order.adjustments.update_all(state: 'closed')
    end

    Viauco::Shipment.shipped.includes(:adjustment).find_each do |shipment|
      shipment.adjustment.update_column(:state, 'finalized') if shipment.adjustment
    end

    Viauco::Adjustment.where(state: nil).update_all(state: 'open')
  end

  def down
  end
end
