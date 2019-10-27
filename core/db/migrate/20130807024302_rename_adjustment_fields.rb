class RenameAdjustmentFields < ActiveRecord::Migration[4.2]
  def up
    # Add Temporary index
    add_index :viauco_adjustments, :adjustable_type unless index_exists?(:viauco_adjustments, :adjustable_type)

    remove_column :viauco_adjustments, :originator_id
    remove_column :viauco_adjustments, :originator_type

    add_column :viauco_adjustments, :order_id, :integer unless column_exists?(:viauco_adjustments, :order_id)

    # This enables the Viauco::Order#all_adjustments association to work correctly
    Viauco::Adjustment.reset_column_information
    Viauco::Adjustment.where(adjustable_type: "Viauco::Order").find_each do |adjustment|
      adjustment.update_column(:order_id, adjustment.adjustable_id)
    end

    # Remove Temporary index
    remove_index :viauco_adjustments, :adjustable_type if index_exists?(:viauco_adjustments, :adjustable_type)
  end
end
