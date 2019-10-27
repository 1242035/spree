class AddPreferenceStoreToEverything < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_calculators, :preferences, :text
    add_column :viauco_gateways, :preferences, :text
    add_column :viauco_payment_methods, :preferences, :text
    add_column :viauco_promotion_rules, :preferences, :text
  end
end
