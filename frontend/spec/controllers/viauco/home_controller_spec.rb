require 'spec_helper'

describe Viauco::HomeController, type: :controller do
  it 'provides current user to the searcher class' do
    user = mock_model(Viauco.user_class, last_incomplete_viauco_order: nil, viauco_api_key: 'fake')
    allow(controller).to receive_messages try_viauco_current_user: user
    expect_any_instance_of(Viauco::Config.searcher_class).to receive(:current_user=).with(user)
    get :index
    expect(response.status).to eq(200)
  end

  context 'layout' do
    it 'renders default layout' do
      get :index
      expect(response).to render_template(layout: 'viauco/layouts/viauco_application')
    end

    context 'different layout specified in config' do
      before { Viauco::Config.layout = 'layouts/application' }

      it 'renders specified layout' do
        get :index
        expect(response).to render_template(layout: 'layouts/application')
      end
    end
  end

  context 'index products' do
    it 'calls includes when the retrieved_products object responds to it' do
      searcher = double('Searcher')
      allow(controller).to receive_messages build_searcher: searcher
      expect(searcher).to receive_message_chain('retrieve_products.includes')

      get :index
    end

    it "does not call includes when it's not available" do
      searcher = double('Searcher')
      allow(controller).to receive_messages build_searcher: searcher
      allow(searcher).to receive(:retrieve_products).and_return([])

      get :index

      expect(assigns(:products)).to eq([])
    end
  end
end
