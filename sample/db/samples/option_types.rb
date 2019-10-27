option_types_attributes = [
  {
    name: 'tshirt-size',
    presentation: 'Size',
    position: 1
  },
  {
    name: 'tshirt-color',
    presentation: 'Color',
    position: 2
  }
]

option_types_attributes.each do |attrs|
  Viauco::OptionType.where(attrs).first_or_create!
end
