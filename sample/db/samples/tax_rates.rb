north_america = Viauco::Zone.find_by!(name: 'North America')
clothing = Viauco::TaxCategory.find_by!(name: 'Clothing')

Viauco::TaxRate.where(
  name: 'North America',
  zone: north_america,
  amount: 0.05,
  tax_category: clothing
).first_or_create! do |tax_rate|
  tax_rate.calculator = Viauco::Calculator::DefaultTax.create!
end
