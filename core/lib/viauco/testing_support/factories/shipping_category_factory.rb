FactoryBot.define do
  factory :shipping_category, class: Viauco::ShippingCategory do
    sequence(:name) { |n| "ShippingCategory ##{n}" }
  end
end
