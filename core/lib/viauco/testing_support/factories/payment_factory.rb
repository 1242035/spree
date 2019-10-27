FactoryBot.define do
  factory :payment, class: Viauco::Payment do
    order
    amount        { 45.75 }
    state         { 'checkout' }
    response_code { '12345' }

    association(:payment_method, factory: :credit_card_payment_method)
    association(:source, factory: :credit_card)

    factory :payment_with_refund do
      state { 'completed' }
      after :create do |payment|
        create(:refund, amount: 5, payment: payment)
      end
    end
  end

  factory :check_payment, class: Viauco::Payment do
    amount { 45.75 }
    order

    association(:payment_method, factory: :check_payment_method)
  end

  factory :store_credit_payment, class: Viauco::Payment, parent: :payment do
    association(:payment_method, factory: :store_credit_payment_method)
    association(:source, factory: :store_credit)
  end
end
