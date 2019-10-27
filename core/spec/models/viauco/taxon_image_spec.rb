require 'spec_helper'

describe Viauco::TaxonImage, type: :model do
  context 'validation' do
    let(:viauco_image) { Viauco::TaxonImage.new }
    let(:image_file) { File.open(Viauco::Core::Engine.root + 'spec/fixtures' + 'thinking-cat.jpg') }
    let(:text_file) { File.open(Viauco::Core::Engine.root + 'spec/fixtures' + 'text-file.txt') }

    it 'has allowed attachment content type' do
      viauco_image.attachment.attach(io: image_file, filename: 'thinking-cat.jpg', content_type: 'image/jpeg')
      expect(viauco_image).to be_valid
    end

    it 'has no allowed attachment content type' do
      viauco_image.attachment.attach(io: text_file, filename: 'text-file.txt', content_type: 'text/plain')
      expect(viauco_image).not_to be_valid
    end
  end
end
