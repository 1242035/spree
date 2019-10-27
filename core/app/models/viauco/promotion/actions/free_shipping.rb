module Viauco
  class Promotion
    module Actions
      class FreeShipping < Viauco::PromotionAction
        include Viauco::AdjustmentSource

        def perform(payload = {})
          order = payload[:order]

          create_unique_adjustments(order, order.shipments)
        end

        def compute_amount(shipment)
          shipment.cost * -1
        end
      end
    end
  end
end
