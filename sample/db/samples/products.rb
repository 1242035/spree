Viauco::Sample.load_sample('tax_categories')
Viauco::Sample.load_sample('shipping_categories')

clothing = Viauco::TaxCategory.find_by!(name: 'Clothing')

products = [
  {
    name: 'Ruby on Rails Tote',
    tax_category: clothing,
    price: 15.99,
    eur_price: 14
  },
  {
    name: 'Ruby on Rails Bag',
    tax_category: clothing,
    price: 22.99,
    eur_price: 19
  },
  {
    name: 'Ruby on Rails Baseball Jersey',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Ruby on Rails Jr. Spaghetti',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16

  },
  {
    name: 'Ruby on Rails Ringer T-Shirt',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Ruby Baseball Jersey',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Apache Baseball Jersey',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Viauco Baseball Jersey',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Viauco Jr. Spaghetti',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Viauco Ringer T-Shirt',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Viauco Tote',
    tax_category: clothing,
    price: 15.99,
    eur_price: 14
  },
  {
    name: 'Viauco Bag',
    tax_category: clothing,
    price: 22.99,
    eur_price: 19
  },
  {
    name: 'Ruby on Rails Mug',
    price: 13.99,
    eur_price: 12
  },
  {
    name: 'Ruby on Rails Stein',
    price: 16.99,
    eur_price: 14
  },
  {
    name: 'Viauco Stein',
    price: 16.99,
    eur_price: 14
  },
  {
    name: 'Viauco Mug',
    price: 13.99,
    eur_price: 12
  }
]

default_shipping_category = Viauco::ShippingCategory.find_by!(name: 'Default')

products.each do |product_attrs|
  Viauco::Config[:currency] = 'USD'
  eur_price = product_attrs.delete(:eur_price)

  new_product = Viauco::Product.where(name: product_attrs[:name],
                                     tax_category: product_attrs[:tax_category]).first_or_create! do |product|
    product.price = product_attrs[:price]
    product.description = FFaker::Lorem.paragraph
    product.available_on = Time.zone.now
    product.shipping_category = default_shipping_category
  end

  next unless new_product

  Viauco::Config[:currency] = 'EUR'
  new_product.reload
  new_product.price = eur_price
  new_product.save
end

Viauco::Config[:currency] = 'USD'
