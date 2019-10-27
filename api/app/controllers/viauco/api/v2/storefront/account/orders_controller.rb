module Viauco
  module Api
    module V2
      module Storefront
        module Account
          class OrdersController < ::Viauco::Api::V2::BaseController
            include Viauco::Api::V2::CollectionOptionsHelpers
            before_action :require_viauco_current_user

            def index
              render_serialized_payload { serialize_collection(paginated_collection) }
            end

            def show
              viauco_authorize! :show, resource

              render_serialized_payload { serialize_resource(resource) }
            end

            private

            def sorted_collection
              collection_sorter.new(collection, params).call
            end

            def collection
              collection_finder.new(user: viauco_current_user).execute
            end

            def resource
              resource = resource_finder.new(user: viauco_current_user, number: params[:id]).execute.take
              raise ActiveRecord::RecordNotFound if resource.nil?

              resource
            end

            def collection_serializer
              Viauco::Api::Dependencies.storefront_cart_serializer.constantize
            end

            def resource_serializer
              Viauco::Api::Dependencies.storefront_cart_serializer.constantize
            end

            def collection_finder
              Viauco::Api::Dependencies.storefront_completed_order_finder.constantize
            end

            def resource_finder
              Viauco::Api::Dependencies.storefront_completed_order_finder.constantize
            end

            def collection_sorter
              Viauco::Api::Dependencies.storefront_order_sorter.constantize
            end

            def collection_paginator
              Viauco::Api::Dependencies.storefront_collection_paginator.constantize
            end
          end
        end
      end
    end
  end
end
