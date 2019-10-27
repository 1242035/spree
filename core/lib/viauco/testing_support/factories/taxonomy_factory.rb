FactoryBot.define do
  factory :taxonomy, class: Viauco::Taxonomy do
    sequence(:name) { |n| "taxonomy_#{n}" }
  end
end
