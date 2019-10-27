require_dependency 'viauco/shipping_calculator'

module Viauco
  module Calculator::Shipping
    class PerItem < ShippingCalculator
      preference :amount, :decimal, default: 0
      preference :currency, :string, default: -> { Viauco::Config[:currency] }

      def self.description
        Viauco.t(:shipping_flat_rate_per_item)
      end

      def compute_package(package)
        compute_from_quantity(package.contents.sum(&:quantity))
      end

      def compute_from_quantity(quantity)
        preferred_amount * quantity
      end
    end
  end
end
