class UpgradeAdjustments < ActiveRecord::Migration[4.2]
  def up
    # Add Temporary index
    add_index :viauco_adjustments, :originator_type unless index_exists?(:viauco_adjustments, :originator_type)

    # Temporarily make originator association available
    Viauco::Adjustment.class_eval do
      belongs_to :originator, polymorphic: true
    end
    # Shipping adjustments are now tracked as fields on the object
    Viauco::Adjustment.where(source_type: "Viauco::Shipment").find_each do |adjustment|
      # Account for possible invalid data
      next if adjustment.source.nil?
      adjustment.source.update_column(:cost, adjustment.amount)
      adjustment.destroy!
    end

    # Tax adjustments have their sources altered
    Viauco::Adjustment.where(originator_type: "Viauco::TaxRate").find_each do |adjustment|
      adjustment.source_id = adjustment.originator_id
      adjustment.source_type = "Viauco::TaxRate"
      adjustment.save!
    end

    # Promotion adjustments have their source altered also
    Viauco::Adjustment.where(originator_type: "Viauco::PromotionAction").find_each do |adjustment|
      next if adjustment.originator.nil?
      adjustment.source = adjustment.originator
      begin
        if adjustment.source.calculator_type == "Viauco::Calculator::FreeShipping"
          # Previously this was a Viauco::Promotion::Actions::CreateAdjustment
          # And it had a calculator to work out FreeShipping
          # In Viauco 2.2, the "calculator" is now the action itself.
          adjustment.source.becomes(Viauco::Promotion::Actions::FreeShipping)
        end
      rescue
        # Fail silently. This is primarily in instances where the calculator no longer exists
      end

      adjustment.save!
    end

    # Remove Temporary index
    remove_index :viauco_adjustments, :originator_type if index_exists?(:viauco_adjustments, :originator_type)
  end
end
