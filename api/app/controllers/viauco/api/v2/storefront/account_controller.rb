module Viauco
  module Api
    module V2
      module Storefront
        class AccountController < ::Viauco::Api::V2::BaseController
          before_action :require_viauco_current_user

          def show
            render_serialized_payload { serialize_resource(resource) }
          end

          private

          def resource
            viauco_current_user
          end

          def resource_serializer
            Viauco::Api::Dependencies.storefront_user_serializer.constantize
          end
        end
      end
    end
  end
end
