Viauco::Sample.load_sample('products')

size = Viauco::OptionType.find_by!(presentation: 'Size')
color = Viauco::OptionType.find_by!(presentation: 'Color')

ror_baseball_jersey = Viauco::Product.find_by!(name: 'Ruby on Rails Baseball Jersey')
ror_baseball_jersey.option_types = [size, color]
ror_baseball_jersey.save!

viauco_baseball_jersey = Viauco::Product.find_by!(name: 'Viauco Baseball Jersey')
viauco_baseball_jersey.option_types = [size, color]
viauco_baseball_jersey.save!
