require 'spec_helper'

module Viauco
  module Admin
    RSpec.describe 'AdminPath', type: :routing do
      it 'shoud route to admin by default' do
        expect(viauco.admin_path).to eq('/admin')
      end

      it 'routes to the the configured path' do
        Viauco.admin_path = '/secret'
        Rails.application.reload_routes!
        expect(viauco.admin_path).to eq('/secret')

        # restore the path for other tests
        Viauco.admin_path = '/admin'
        Rails.application.reload_routes!
        expect(viauco.admin_path).to eq('/admin')
      end
    end
  end
end
