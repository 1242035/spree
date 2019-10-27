module Viauco
  module Cart
    class Create
      prepend Viauco::ServiceModule::Base

      def call(user:, store:, currency:, order_params: nil)
        order_params ||= {}

        default_params = {
          user: user,
          store: store,
          currency: currency,
          token: Viauco::GenerateToken.new.call(Viauco::Order)
        }

        order = Viauco::Order.create!(default_params.merge(order_params))
        success(order)
      end
    end
  end
end
