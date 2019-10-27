class AddZipcodeRequiredToViaucoCountries < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_countries, :zipcode_required, :boolean, default: true
    Viauco::Country.reset_column_information
    Viauco::Country.where(iso: Viauco::Address::NO_ZIPCODE_ISO_CODES).update_all(zipcode_required: false)
  end
end
