require 'spec_helper'

describe 'Template rendering', type: :feature do
  it 'layout should have canonical tag referencing site url' do
    Viauco::Store.create!(code: 'viauco', name: 'My Viauco Store', url: 'viaucostore.example.com', mail_from_address: 'test@example.com')

    visit viauco.root_path
    expect(find('link[rel=canonical]', visible: false)[:href]).to eql('http://viaucostore.example.com/')
  end
end
