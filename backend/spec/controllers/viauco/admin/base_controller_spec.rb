# Viauco's rpsec controller tests get the Viauco::ControllerHacks
# we don't need those for the anonymous controller here, so
# we call process directly instead of get
require 'spec_helper'

describe Viauco::Admin::BaseController, type: :controller do
  controller(Viauco::Admin::BaseController) do
    def index
      authorize! :update, Viauco::Order
      render plain: 'test'
    end
  end

  context 'unauthorized request' do
    before do
      allow_any_instance_of(Viauco::Admin::BaseController).to receive(:viauco_current_user).and_return(nil)
    end

    it 'redirects to root' do
      allow(controller).to receive_message_chain(:viauco, :root_path).and_return('/root')
      get :index
      expect(response).to redirect_to '/root'
    end
  end

  context '#generate_api_key' do
    let(:user) { mock_model(Viauco.user_class, has_viauco_role?: true) }

    before do
      allow(controller).to receive(:authorize_admin).and_return(true)
      allow(controller).to receive(:try_viauco_current_user) { user }
    end

    it 'generates the API key for a user when they visit' do
      expect(user).to receive(:viauco_api_key).and_return(nil)
      expect(user).to receive(:generate_viauco_api_key!)
      get :index
    end

    it 'does not attempt to regenerate the API key if the key is already set' do
      expect(user).to receive(:viauco_api_key).and_return('fake')
      expect(user).not_to receive(:generate_viauco_api_key!)
      get :index
    end
  end
end
