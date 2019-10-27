require 'spec_helper'

describe Viauco::TaxonsController, type: :controller do
  it 'provides the current user to the searcher class' do
    taxon = create(:taxon, permalink: 'test')
    user = mock_model(Viauco.user_class, last_incomplete_viauco_order: nil, viauco_api_key: 'fake')
    allow(controller).to receive_messages viauco_current_user: user
    expect_any_instance_of(Viauco::Config.searcher_class).to receive(:current_user=).with(user)
    get :show, params: { id: taxon.permalink }
    expect(response.status).to eq(200)
  end
end
