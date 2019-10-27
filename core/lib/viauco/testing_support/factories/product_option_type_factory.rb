FactoryBot.define do
  factory :product_option_type, class: Viauco::ProductOptionType do
    product
    option_type
  end
end
