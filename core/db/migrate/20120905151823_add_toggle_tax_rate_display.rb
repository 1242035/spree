class AddToggleTaxRateDisplay < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_tax_rates, :show_rate_in_label, :boolean, default: true
  end
end
