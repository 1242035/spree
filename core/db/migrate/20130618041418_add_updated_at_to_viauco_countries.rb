class AddUpdatedAtToViaucoCountries < ActiveRecord::Migration[4.2]
  def up
    add_column :viauco_countries, :updated_at, :datetime
  end

  def down
    remove_column :viauco_countries, :updated_at
  end
end
