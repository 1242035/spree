require 'spec_helper'

describe 'setting locale', type: :feature do
  stub_authorization!

  before do
    I18n.locale = I18n.default_locale
    I18n.backend.store_translations(:fr,
                                    date: {
                                      month_names: []
                                    },
                                    viauco: {
                                      admin: {
                                        tab: { orders: 'Ordres' }
                                      },
                                      listing_orders: 'Ordres'
                                    })
    Viauco::Backend::Config[:locale] = 'fr'
  end

  after do
    I18n.locale = I18n.default_locale
    Viauco::Backend::Config[:locale] = 'en'
  end

  it 'is in french' do
    visit viauco.admin_path
    click_link 'Ordres'
    expect(page).to have_content('Ordres')
  end
end
