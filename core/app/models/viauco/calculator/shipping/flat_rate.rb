require_dependency 'viauco/shipping_calculator'

module Viauco
  module Calculator::Shipping
    class FlatRate < ShippingCalculator
      preference :amount, :decimal, default: 0
      preference :currency, :string, default: -> { Viauco::Config[:currency] }

      def self.description
        Viauco.t(:shipping_flat_rate_per_order)
      end

      def compute_package(_package)
        preferred_amount
      end
    end
  end
end
