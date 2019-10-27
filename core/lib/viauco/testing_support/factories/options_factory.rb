FactoryBot.define do
  factory :option_value, class: Viauco::OptionValue do
    sequence(:name) { |n| "Size-#{n}" }
    presentation    { 'S' }
    option_type
  end

  factory :option_type, class: Viauco::OptionType do
    sequence(:name) { |n| "foo-size-#{n}" }
    presentation    { 'Size' }
  end
end
