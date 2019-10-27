module Viauco
  class OrderPromotion < Viauco::Base
    belongs_to :order, class_name: 'Viauco::Order'
    belongs_to :promotion, class_name: 'Viauco::Promotion'

    delegate :name, :description, :code, to: :promotion
    delegate :currency, to: :order

    extend Viauco::DisplayMoney
    money_methods :amount

    def amount
      order.all_adjustments.promotion.where(source: promotion.actions).sum(:amount)
    end
  end
end
