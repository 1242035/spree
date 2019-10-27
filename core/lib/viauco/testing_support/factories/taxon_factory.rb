FactoryBot.define do
  factory :taxon, class: Viauco::Taxon do
    sequence(:name) { |n| "taxon_#{n}" }
    association(:taxonomy, strategy: :create)
    parent_id { taxonomy.root.id }
  end
end
