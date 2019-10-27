class CreateDefaultStock < ActiveRecord::Migration[4.2]
  def up
    unless column_exists? :viauco_stock_locations, :default
      add_column :viauco_stock_locations, :default, :boolean, null: false, default: false
    end

    Viauco::StockLocation.skip_callback(:create, :after, :create_stock_items)
    Viauco::StockLocation.skip_callback(:save, :after, :ensure_one_default)
    location = Viauco::StockLocation.new(name: 'default')
    location.save(validate: false)

    Viauco::Variant.find_each do |variant|
      stock_item = Viauco::StockItem.unscoped.build(stock_location: location, variant: variant)
      stock_item.send(:count_on_hand=, variant.count_on_hand)
      # Avoid running default_scope defined by acts_as_paranoid, related to #3805,
      # validations would run a query with a delete_at column that might not be present yet
      stock_item.save! validate: false
    end

    remove_column :viauco_variants, :count_on_hand
  end

  def down
    add_column :viauco_variants, :count_on_hand, :integer

    Viauco::StockItem.find_each do |stock_item|
      stock_item.variant.update_column :count_on_hand, stock_item.count_on_hand
    end

    Viauco::StockLocation.delete_all
    Viauco::StockItem.delete_all
  end
end
