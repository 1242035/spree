class RemoveUserIndexFromViaucoStateChanges < ActiveRecord::Migration[4.2]
  def up
    if index_exists? :viauco_state_changes, :user_id
      remove_index :viauco_state_changes, :user_id
    end

  end

  def down
    unless index_exists? :viauco_state_changes, :user_id
      add_index :viauco_state_changes, :user_id
    end
  end
end
