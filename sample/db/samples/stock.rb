Viauco::Sample.load_sample('variants')

country =  Viauco::Country.find_by(iso: 'US')
location = Viauco::StockLocation.first_or_create!(name: 'default',
                                                 address1: 'Example Street',
                                                 city: 'City',
                                                 zipcode: '12345',
                                                 country: country,
                                                 state: country.states.first)
location.active = true
location.save!

Viauco::Variant.all.each do |variant|
  next if variant.is_master? && variant.product.has_variants?

  variant.stock_items.each do |stock_item|
    Viauco::StockMovement.create(quantity: 10, stock_item: stock_item)
  end
end
