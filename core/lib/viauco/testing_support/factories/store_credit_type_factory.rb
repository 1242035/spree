FactoryBot.define do
  factory :primary_credit_type, class: Viauco::StoreCreditType do
    name      { Viauco::StoreCreditType::DEFAULT_TYPE_NAME }
    priority  { '1' }
  end

  factory :secondary_credit_type, class: Viauco::StoreCreditType do
    name      { 'Non-expiring' }
    priority  { '2' }
  end
end
