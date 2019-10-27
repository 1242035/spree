class AddStateToViaucoAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_adjustments, :state, :string
    remove_column :viauco_adjustments, :locked
  end
end
