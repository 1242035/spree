class RemoveValueTypeFromViaucoPreferences < ActiveRecord::Migration[4.2]
  def up
    remove_column :viauco_preferences, :value_type
  end
  def down
    raise ActiveRecord::IrreversableMigration
  end
end
