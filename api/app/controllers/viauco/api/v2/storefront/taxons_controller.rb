module Viauco
  module Api
    module V2
      module Storefront
        class TaxonsController < ::Viauco::Api::V2::BaseController
          include Viauco::Api::V2::CollectionOptionsHelpers

          def index
            render_serialized_payload { serialize_collection(paginated_collection) }
          end

          def show
            render_serialized_payload { serialize_resource(resource) }
          end

          private

          def collection_serializer
            Viauco::Api::Dependencies.storefront_taxon_serializer.constantize
          end

          def resource_serializer
            Viauco::Api::Dependencies.storefront_taxon_serializer.constantize
          end

          def collection_finder
            Viauco::Api::Dependencies.storefront_taxon_finder.constantize
          end

          def paginated_collection
            collection_paginator.new(collection, params).call
          end

          def collection
            collection_finder.new(scope: scope, params: params).execute
          end

          def resource
            scope.find_by(permalink: params[:id]) || scope.find(params[:id])
          end

          def scope
            Viauco::Taxon.accessible_by(current_ability, :show).includes(scope_includes)
          end

          def scope_includes
            node_includes = %i[icon products parent taxonomy]

            {
              parent: node_includes,
              children: node_includes,
              taxonomy: [root: node_includes],
              products: [],
              icon: []
            }
          end
        end
      end
    end
  end
end
