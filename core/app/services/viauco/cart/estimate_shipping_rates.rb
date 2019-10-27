module Viauco
  module Cart
    class EstimateShippingRates
      prepend Viauco::ServiceModule::Base

      def call(order:, country_iso: nil)
        country_id = country_id(country_iso)
        dummy_order = generate_dummy_order(order, country_id)

        packages = ::Viauco::Stock::Coordinator.new(dummy_order).packages
        estimator = ::Viauco::Stock::Estimator.new(dummy_order)
        shipping_rates = if order.line_items.any? && packages.any?
                           estimator.shipping_rates(packages.first)
                         else
                           []
                         end

        success(shipping_rates)
      end

      private

      def country_id(country_iso)
        if country_iso.present?
          ::Viauco::Country.by_iso(country_iso)&.id
        else
          ::Viauco::Country.default.id
        end
      end

      def generate_dummy_order(order, country_id)
        dummy_order = order.dup
        dummy_order.line_items = order.line_items
        dummy_order.ship_address = ::Viauco::Address.new(country_id: country_id)
        dummy_order
      end
    end
  end
end
