class RenameTrackerKindField < ActiveRecord::Migration[5.1]
  def change
    rename_column :viauco_trackers, :kind, :engine
  end
end
