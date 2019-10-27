FactoryBot.define do
  factory :promotion_rule, class: Viauco::PromotionRule do
    association :promotion
  end
end
