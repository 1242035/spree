module Viauco
  module Checkout
    class Complete
      prepend Viauco::ServiceModule::Base

      def call(order:)
        Viauco::Dependencies.checkout_next_service.constantize.call(order: order) until cannot_make_transition?(order)

        if order.reload.complete?
          success(order)
        else
          failure(order)
        end
      end

      private

      def cannot_make_transition?(order)
        order.complete? || order.errors.present?
      end
    end
  end
end
