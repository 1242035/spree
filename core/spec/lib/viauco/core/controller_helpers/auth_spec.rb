require 'spec_helper'
require 'viauco/testing_support/url_helpers'

class FakesController < ApplicationController
  include Viauco::Core::ControllerHelpers::Auth
  def index
    render plain: 'index'
  end
end

describe Viauco::Core::ControllerHelpers::Auth, type: :controller do
  controller(FakesController) {}
  include Viauco::TestingSupport::UrlHelpers

  describe '#current_ability' do
    it 'returns Viauco::Ability instance' do
      expect(controller.current_ability.class).to eq Viauco::Ability
    end
  end

  describe '#redirect_back_or_default' do
    controller(FakesController) do
      def index
        redirect_back_or_default('/')
      end
    end
    it 'redirects to session url' do
      session[:viauco_user_return_to] = '/redirect'
      get :index
      expect(response).to redirect_to('/redirect')
    end
    it 'redirects to HTTP_REFERER' do
      request.env['HTTP_REFERER'] = '/dummy_redirect'
      get :index
      expect(response).to redirect_to('/dummy_redirect')
    end
    it 'redirects to default page' do
      get :index
      expect(response).to redirect_to('/')
    end
  end

  describe '#set_token' do
    controller(FakesController) do
      def index
        set_token
        render plain: 'index'
      end
    end
    it 'sends cookie header' do
      get :index
      expect(response.cookies['token']).not_to be_nil
    end
    it 'sets httponly flag' do
      get :index
      expect(response['Set-Cookie']).to include('HttpOnly')
    end
  end

  describe '#store_location' do
    it 'sets session return url' do
      allow(controller).to receive_messages(request: double(fullpath: '/redirect'))
      controller.store_location
      expect(session[:viauco_user_return_to]).to eq '/redirect'
    end
  end

  describe '#try_viauco_current_user' do
    it 'calls viauco_current_user when define viauco_current_user method' do
      expect(controller).to receive(:viauco_current_user)
      controller.try_viauco_current_user
    end
    it 'calls current_viauco_user when define current_viauco_user method' do
      expect(controller).to receive(:current_viauco_user)
      controller.try_viauco_current_user
    end
    it 'returns nil' do
      expect(controller.try_viauco_current_user).to eq nil
    end
  end

  describe '#redirect_unauthorized_access' do
    controller(FakesController) do
      def index
        redirect_unauthorized_access
      end
    end
    context 'when logged in' do
      before do
        allow(controller).to receive_messages(try_viauco_current_user: double('User', id: 1, last_incomplete_viauco_order: nil))
      end

      it 'redirects forbidden path' do
        get :index
        expect(response).to redirect_to(viauco.forbidden_path)
      end
    end

    context 'when guest user' do
      before do
        allow(controller).to receive_messages(try_viauco_current_user: nil)
      end

      it 'redirects login path' do
        allow(controller).to receive_messages(viauco_login_path: '/login')
        get :index
        expect(response).to redirect_to('/login')
      end
      it 'redirects root path' do
        allow(controller).to receive_message_chain(:viauco, :root_path).and_return('/root_path')
        get :index
        expect(response).to redirect_to('/root_path')
      end
    end
  end
end
