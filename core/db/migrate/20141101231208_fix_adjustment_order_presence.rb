class FixAdjustmentOrderPresence < ActiveRecord::Migration[4.2]
  def change
    say 'Fixing adjustments without direct order reference'
    Viauco::Adjustment.where(order: nil).find_each do |adjustment|
      adjustable = adjustment.adjustable
      if adjustable.is_a? Viauco::Order
        adjustment.update!(order_id: adjustable.id)
      else
        adjustment.update!(adjustable: adjustable.order)
      end
    end
  end
end
