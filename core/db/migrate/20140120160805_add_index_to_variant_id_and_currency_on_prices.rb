class AddIndexToVariantIdAndCurrencyOnPrices < ActiveRecord::Migration[4.2]
  def change
    add_index :viauco_prices, [:variant_id, :currency]
  end
end
