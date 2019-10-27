module Viauco
  module Api
    module V2
      module Storefront
        class OrderStatusController < ::Viauco::Api::V2::BaseController
          include Viauco::Api::V2::Storefront::OrderConcern

          def show
            render_serialized_payload { serialize_resource(resource) }
          end

          private

          def resource
            resource = resource_finder.new(number: params[:number], token: order_token).execute.take
            raise ActiveRecord::RecordNotFound if resource.nil?

            resource
          end

          def resource_finder
            Viauco::Api::Dependencies.storefront_completed_order_finder.constantize
          end

          def resource_serializer
            Viauco::Api::Dependencies.storefront_cart_serializer.constantize
          end
        end
      end
    end
  end
end
