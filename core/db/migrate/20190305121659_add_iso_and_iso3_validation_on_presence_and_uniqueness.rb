class AddIsoAndIso3ValidationOnPresenceAndUniqueness < ActiveRecord::Migration[5.2]
  def up
    Viauco::Country.where.not(id: Viauco::Country.group(:iso).select("min(id)")).destroy_all
    Viauco::Country.where.not(id: Viauco::Country.group(:iso3).select("min(id)")).destroy_all

    change_column_null(:viauco_countries, :iso, false)
    change_column_null(:viauco_countries, :iso3, false)
    add_index :viauco_countries, :iso, unique: true
    add_index :viauco_countries, :iso3, unique: true
  end

  def down
    change_column_null(:viauco_countries, :iso, true)
    change_column_null(:viauco_countries, :iso3, true)
    remove_index :viauco_countries, :iso, unique: true
    remove_index :viauco_countries, :iso3, unique: true
  end
end
