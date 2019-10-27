Viauco::Sample.load_sample('option_values')
Viauco::Sample.load_sample('products')

ror_baseball_jersey = Viauco::Product.find_by!(name: 'Ruby on Rails Baseball Jersey')
ror_tote = Viauco::Product.find_by!(name: 'Ruby on Rails Tote')
ror_bag = Viauco::Product.find_by!(name: 'Ruby on Rails Bag')
ror_jr_spaghetti = Viauco::Product.find_by!(name: 'Ruby on Rails Jr. Spaghetti')
ror_mug = Viauco::Product.find_by!(name: 'Ruby on Rails Mug')
ror_ringer = Viauco::Product.find_by!(name: 'Ruby on Rails Ringer T-Shirt')
ror_stein = Viauco::Product.find_by!(name: 'Ruby on Rails Stein')
viauco_baseball_jersey = Viauco::Product.find_by!(name: 'Viauco Baseball Jersey')
viauco_stein = Viauco::Product.find_by!(name: 'Viauco Stein')
viauco_jr_spaghetti = Viauco::Product.find_by!(name: 'Viauco Jr. Spaghetti')
viauco_mug = Viauco::Product.find_by!(name: 'Viauco Mug')
viauco_ringer = Viauco::Product.find_by!(name: 'Viauco Ringer T-Shirt')
viauco_tote = Viauco::Product.find_by!(name: 'Viauco Tote')
viauco_bag = Viauco::Product.find_by!(name: 'Viauco Bag')
ruby_baseball_jersey = Viauco::Product.find_by!(name: 'Ruby Baseball Jersey')
apache_baseball_jersey = Viauco::Product.find_by!(name: 'Apache Baseball Jersey')

small = Viauco::OptionValue.where(name: 'Small').first
medium = Viauco::OptionValue.where(name: 'Medium').first
large = Viauco::OptionValue.where(name: 'Large').first
extra_large = Viauco::OptionValue.where(name: 'Extra Large').first

red = Viauco::OptionValue.where(name: 'Red').first
blue = Viauco::OptionValue.where(name: 'Blue').first
green = Viauco::OptionValue.where(name: 'Green').first

variants = [
  {
    product: ror_baseball_jersey,
    option_values: [small, red],
    sku: 'ROR-00001',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [small, blue],
    sku: 'ROR-00002',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [small, green],
    sku: 'ROR-00003',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [medium, red],
    sku: 'ROR-00004',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [medium, blue],
    sku: 'ROR-00005',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [medium, green],
    sku: 'ROR-00006',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [large, red],
    sku: 'ROR-00007',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [large, blue],
    sku: 'ROR-00008',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [large, green],
    sku: 'ROR-00009',
    cost_price: 17
  },
  {
    product: ror_baseball_jersey,
    option_values: [extra_large, green],
    sku: 'ROR-00010',
    cost_price: 17
  }
]

masters = {
  ror_baseball_jersey => {
    sku: 'ROR-001',
    cost_price: 17
  },
  ror_tote => {
    sku: 'ROR-00011',
    cost_price: 17
  },
  ror_bag => {
    sku: 'ROR-00012',
    cost_price: 21
  },
  ror_jr_spaghetti => {
    sku: 'ROR-00013',
    cost_price: 17
  },
  ror_mug => {
    sku: 'ROR-00014',
    cost_price: 11
  },
  ror_ringer => {
    sku: 'ROR-00015',
    cost_price: 17
  },
  ror_stein => {
    sku: 'ROR-00016',
    cost_price: 15
  },
  apache_baseball_jersey => {
    sku: 'APC-00001',
    cost_price: 17
  },
  ruby_baseball_jersey => {
    sku: 'RUB-00001',
    cost_price: 17
  },
  viauco_baseball_jersey => {
    sku: 'SPR-00001',
    cost_price: 17
  },
  viauco_stein => {
    sku: 'SPR-00016',
    cost_price: 15
  },
  viauco_jr_spaghetti => {
    sku: 'SPR-00013',
    cost_price: 17
  },
  viauco_mug => {
    sku: 'SPR-00014',
    cost_price: 11
  },
  viauco_ringer => {
    sku: 'SPR-00015',
    cost_price: 17
  },
  viauco_tote => {
    sku: 'SPR-00011',
    cost_price: 13
  },
  viauco_bag => {
    sku: 'SPR-00012',
    cost_price: 21
  }
}

variants.each do |attrs|
  Viauco::Variant.create!(attrs) if Viauco::Variant.where(product_id: attrs[:product].id, sku: attrs[:sku]).none?
end

masters.each do |product, variant_attrs|
  product.master.update!(variant_attrs)
end
