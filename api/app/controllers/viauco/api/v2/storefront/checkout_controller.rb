module Viauco
  module Api
    module V2
      module Storefront
        class CheckoutController < ::Viauco::Api::V2::BaseController
          include Viauco::Api::V2::Storefront::OrderConcern
          before_action :ensure_order

          def next
            viauco_authorize! :update, viauco_current_order, order_token

            result = next_service.call(order: viauco_current_order)

            render_order(result)
          end

          def advance
            viauco_authorize! :update, viauco_current_order, order_token

            result = advance_service.call(order: viauco_current_order)

            render_order(result)
          end

          def complete
            viauco_authorize! :update, viauco_current_order, order_token

            result = complete_service.call(order: viauco_current_order)

            render_order(result)
          end

          def update
            viauco_authorize! :update, viauco_current_order, order_token

            result = update_service.call(
              order: viauco_current_order,
              params: params,
              # defined in https://github.com/viauco/viauco/blob/master/core/lib/viauco/core/controller_helpers/strong_parameters.rb#L19
              permitted_attributes: permitted_checkout_attributes,
              request_env: request.headers.env
            )

            render_order(result)
          end

          def add_store_credit
            viauco_authorize! :update, viauco_current_order, order_token

            result = add_store_credit_service.call(
              order: viauco_current_order,
              amount: params[:amount].try(:to_f)
            )

            render_order(result)
          end

          def remove_store_credit
            viauco_authorize! :update, viauco_current_order, order_token

            result = remove_store_credit_service.call(order: viauco_current_order)
            render_order(result)
          end

          def shipping_rates
            result = shipping_rates_service.call(order: viauco_current_order)

            render_serialized_payload { serialize_shipping_rates(result.value) }
          end

          def payment_methods
            render_serialized_payload { serialize_payment_methods(viauco_current_order.available_payment_methods) }
          end

          private

          def resource_serializer
            Viauco::Api::Dependencies.storefront_cart_serializer.constantize
          end

          def next_service
            Viauco::Api::Dependencies.storefront_checkout_next_service.constantize
          end

          def advance_service
            Viauco::Api::Dependencies.storefront_checkout_advance_service.constantize
          end

          def add_store_credit_service
            Viauco::Api::Dependencies.storefront_checkout_add_store_credit_service.constantize
          end

          def remove_store_credit_service
            Viauco::Api::Dependencies.storefront_checkout_remove_store_credit_service.constantize
          end

          def complete_service
            Viauco::Api::Dependencies.storefront_checkout_complete_service.constantize
          end

          def update_service
            Viauco::Api::Dependencies.storefront_checkout_update_service.constantize
          end

          def payment_methods_serializer
            Viauco::Api::Dependencies.storefront_payment_method_serializer.constantize
          end

          def shipping_rates_service
            Viauco::Api::Dependencies.storefront_checkout_get_shipping_rates_service.constantize
          end

          def shipping_rates_serializer
            Viauco::Api::Dependencies.storefront_shipment_serializer.constantize
          end

          def serialize_payment_methods(payment_methods)
            payment_methods_serializer.new(payment_methods).serializable_hash
          end

          def serialize_shipping_rates(shipments)
            shipping_rates_serializer.new(
              shipments,
              include: [:shipping_rates],
              params: { show_rates: true }
            ).serializable_hash
          end
        end
      end
    end
  end
end
