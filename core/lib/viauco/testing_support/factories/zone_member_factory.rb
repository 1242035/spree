FactoryBot.define do
  factory :zone_member, class: Viauco::ZoneMember do
    zone { |member| member.association(:zone) }
    zoneable { |member| member.association(:zoneable) }
  end
end
