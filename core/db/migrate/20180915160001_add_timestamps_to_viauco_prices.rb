class AddTimestampsToViaucoPrices < ActiveRecord::Migration[5.2]
  def up
    add_timestamps :viauco_prices, default: Time.current
    change_column_default :viauco_prices, :created_at, nil
    change_column_default :viauco_prices, :updated_at, nil
  end

  def down
    remove_column :viauco_prices, :created_at
    remove_column :viauco_prices, :updated_at
  end
end
