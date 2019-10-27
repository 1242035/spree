require 'spec_helper'

class FakesController < ApplicationController
  include Viauco::Core::ControllerHelpers::Search
end

describe Viauco::Core::ControllerHelpers::Search, type: :controller do
  controller(FakesController) {}

  describe '#build_searcher' do
    it 'returns Viauco::Core::Search::Base instance' do
      allow(controller).to receive_messages(try_viauco_current_user: create(:user),
                                            current_currency: 'USD')
      expect(controller.build_searcher({}).class).to eq Viauco::Core::Search::Base
    end
  end
end
