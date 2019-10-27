FactoryBot.define do
  factory :calculator, class: Viauco::Calculator::FlatRate do
    after(:create) { |c| c.set_preference(:amount, 10.0) }
  end

  factory :no_amount_calculator, class: Viauco::Calculator::FlatRate do
    after(:create) { |c| c.set_preference(:amount, 0) }
  end

  factory :default_tax_calculator, class: Viauco::Calculator::DefaultTax do
  end

  factory :shipping_calculator, class: Viauco::Calculator::Shipping::FlatRate do
    after(:create) { |c| c.set_preference(:amount, 10.0) }
  end

  factory :shipping_no_amount_calculator, class: Viauco::Calculator::Shipping::FlatRate do
    after(:create) { |c| c.set_preference(:amount, 0) }
  end
end
