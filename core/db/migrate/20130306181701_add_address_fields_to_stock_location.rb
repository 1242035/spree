class AddAddressFieldsToStockLocation < ActiveRecord::Migration[4.2]
  def change
    remove_column :viauco_stock_locations, :address_id

    add_column :viauco_stock_locations, :address1, :string
    add_column :viauco_stock_locations, :address2, :string
    add_column :viauco_stock_locations, :city, :string
    add_column :viauco_stock_locations, :state_id, :integer
    add_column :viauco_stock_locations, :state_name, :string
    add_column :viauco_stock_locations, :country_id, :integer
    add_column :viauco_stock_locations, :zipcode, :string
    add_column :viauco_stock_locations, :phone, :string


    usa = Viauco::Country.where(iso: 'US').first
    # In case USA isn't found.
    # See #3115
    country = usa || Viauco::Country.first
    Viauco::Country.reset_column_information
    Viauco::StockLocation.update_all(country_id: country)
  end
end
