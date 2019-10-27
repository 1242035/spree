module Viauco
  class Promotion
    module Actions
      class CreateAdjustment < PromotionAction
        include Viauco::CalculatedAdjustments
        include Viauco::AdjustmentSource

        before_validation -> { self.calculator ||= Calculator::FlatPercentItemTotal.new }

        def perform(options = {})
          order = options[:order]

          create_unique_adjustment(order, order)
        end

        def compute_amount(order)
          [order_total(order), compute(order)].min * -1
        end

        def order_total(order)
          order.item_total + order.ship_total - order.shipping_discount
        end
      end
    end
  end
end
