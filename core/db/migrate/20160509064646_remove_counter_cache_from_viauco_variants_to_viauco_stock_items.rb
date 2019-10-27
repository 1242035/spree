class RemoveCounterCacheFromViaucoVariantsToViaucoStockItems < ActiveRecord::Migration[4.2]
  def up
    if column_exists?(:viauco_variants, :stock_items_count)
      remove_column :viauco_variants, :stock_items_count
    end
  end

  def down
  end
end
