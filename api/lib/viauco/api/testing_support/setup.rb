module Viauco
  module Api
    module TestingSupport
      module Setup
        def sign_in_as_admin!
          let!(:current_api_user) do
            user = stub_model(Viauco.user_class)
            allow(user).to receive_message_chain(:viauco_roles, :pluck).and_return(['admin'])
            allow(user).to receive(:has_viauco_role?).with('admin').and_return(true)
            user
          end
        end
      end
    end
  end
end
