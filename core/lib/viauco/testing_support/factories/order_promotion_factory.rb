FactoryBot.define do
  factory :order_promotion, class: Viauco::OrderPromotion do
    order
    promotion
  end
end
