class AddUpdatedAtToViaucoStates < ActiveRecord::Migration[4.2]
  def up
    add_column :viauco_states, :updated_at, :datetime
  end

  def down
    remove_column :viauco_states, :updated_at
  end
end
