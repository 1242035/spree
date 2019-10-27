class AddIncludedToAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_adjustments, :included, :boolean, default: false unless Viauco::Adjustment.column_names.include?("included")
  end
end
