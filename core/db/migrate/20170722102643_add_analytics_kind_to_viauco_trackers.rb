class AddAnalyticsKindToViaucoTrackers < ActiveRecord::Migration[5.1]
  def change
    add_column :viauco_trackers, :kind, :integer, default: 0, null: false, index: true
  end
end
