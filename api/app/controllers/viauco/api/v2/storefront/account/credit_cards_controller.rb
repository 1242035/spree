module Viauco
  module Api
    module V2
      module Storefront
        module Account
          class CreditCardsController < ::Viauco::Api::V2::BaseController
            before_action :require_viauco_current_user

            def index
              render_serialized_payload { serialize_collection(resource) }
            end

            def show
              render_serialized_payload { serialize_resource(resource) }
            end

            private

            def resource
              resource_finder.new.execute(scope: scope, params: params)
            end

            def collection_serializer
              Viauco::Api::Dependencies.storefront_credit_card_serializer.constantize
            end

            def resource_serializer
              Viauco::Api::Dependencies.storefront_credit_card_serializer.constantize
            end

            def resource_finder
              Viauco::Api::Dependencies.storefront_credit_card_finder.constantize
            end

            def serialize_collection(collection)
              collection_serializer.new(
                collection,
                include: resource_includes,
                fields: sparse_fields
              ).serializable_hash
            end

            def scope
              viauco_current_user.credit_cards.accessible_by(current_ability, :show)
            end
          end
        end
      end
    end
  end
end
