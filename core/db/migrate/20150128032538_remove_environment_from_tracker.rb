class RemoveEnvironmentFromTracker < ActiveRecord::Migration[4.2]
  class Viauco::Tracker < Viauco::Base; end

  def up
    Viauco::Tracker.where('environment != ?', Rails.env).update_all(active: false)
    remove_column :viauco_trackers, :environment
  end
end
