FactoryBot.define do
  factory :store_credit_auth_event, class: Viauco::StoreCreditEvent do
    store_credit       { create(:store_credit) }
    action             { Viauco::StoreCredit::AUTHORIZE_ACTION }
    amount             { 100.00 }
    authorization_code { "#{store_credit.id}-SC-20140602164814476128" }
  end
end
