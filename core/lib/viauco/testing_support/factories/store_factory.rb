FactoryBot.define do
  factory :store, class: Viauco::Store do
    sequence(:code)   { |i| "viauco_#{i}" }
    name              { 'Viauco Test Store' }
    url               { 'www.example.com' }
    mail_from_address { 'viauco@example.org' }
    default_currency  { 'USD' }
  end
end
