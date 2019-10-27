class AddCurrencyToLineItems < ActiveRecord::Migration[4.2]
  def change
    add_column :viauco_line_items, :currency, :string
  end
end
