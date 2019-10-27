FactoryBot.define do
  sequence(:store_credits_order_number) { |n| "R1000#{n}" }

  factory :store_credit, class: Viauco::StoreCredit do
    user
    created_by { create(:user) }
    category { create(:store_credit_category) }
    amount { 150.00 }
    currency { 'USD' }
    credit_type { create(:primary_credit_type) }
  end

  factory :store_credits_order_without_user, class: Viauco::Order do
    number { generate(:store_credits_order_number) }
    bill_address
  end
end
