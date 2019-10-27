class AddDeletedAtToViaucoTaxRates < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_tax_rates, :deleted_at, :datetime
  end
end
