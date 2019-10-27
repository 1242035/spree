class CreateDefaultRefundReason < ActiveRecord::Migration[4.2]
  def up
    Viauco::RefundReason.create!(name: Viauco::RefundReason::RETURN_PROCESSING_REASON, mutable: false)
  end

  def down
    Viauco::RefundReason.find_by(name: Viauco::RefundReason::RETURN_PROCESSING_REASON, mutable: false).destroy
  end
end
