class EnableActsAsParanoidOnCalculators < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_calculators, :deleted_at, :datetime
    add_index :viauco_calculators, :deleted_at
  end
end
