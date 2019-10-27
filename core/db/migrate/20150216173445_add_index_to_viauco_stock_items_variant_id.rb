class AddIndexToViaucoStockItemsVariantId < ActiveRecord::Migration[4.2]
  def up
    unless index_exists? :viauco_stock_items, :variant_id
      add_index :viauco_stock_items, :variant_id
    end
  end

  def down
    if index_exists? :viauco_stock_items, :variant_id
      remove_index :viauco_stock_items, :variant_id
    end
  end
end
