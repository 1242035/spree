class AddCostCurrencyToVariants < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_variants, :cost_currency, :string, after: :cost_price
  end
end
