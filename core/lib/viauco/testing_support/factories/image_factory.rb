FactoryBot.define do
  factory :image, class: Viauco::Image do
    before(:create) do |image|
      image.attachment.attach(io: File.new(Viauco::Core::Engine.root + 'spec/fixtures' + 'thinking-cat.jpg'), filename: 'thinking-cat.jpg')
    end
  end
end
