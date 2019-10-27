require 'spec_helper'

describe Viauco::AppConfiguration, type: :model do
  let (:prefs) { Rails.application.config.viauco.preferences }

  it 'is available from the environment' do
    prefs.layout = 'my/layout'
    expect(prefs.layout).to eq 'my/layout'
  end

  it 'is available as Viauco::Config for legacy access' do
    Viauco::Config.layout = 'my/layout'
    expect(Viauco::Config.layout).to eq 'my/layout'
  end

  it 'uses base searcher class by default' do
    prefs.searcher_class = nil
    expect(prefs.searcher_class).to eq Viauco::Core::Search::Base
  end

  describe 'admin_path' do
    it { expect(Viauco::Config).to have_preference(:admin_path) }
    it { expect(Viauco::Config.preferred_admin_path_type).to eq(:string) }
    it { expect(Viauco::Config.preferred_admin_path_default).to eq('/admin') }
  end
end
