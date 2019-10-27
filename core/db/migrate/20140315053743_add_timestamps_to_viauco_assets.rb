class AddTimestampsToViaucoAssets < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_assets, :created_at, :datetime
    add_column :viauco_assets, :updated_at, :datetime
  end
end
