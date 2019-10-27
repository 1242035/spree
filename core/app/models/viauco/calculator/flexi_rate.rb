require_dependency 'viauco/calculator'

module Viauco
  class Calculator::FlexiRate < Calculator
    preference :first_item,      :decimal, default: 0.0
    preference :additional_item, :decimal, default: 0.0
    preference :max_items,       :integer, default: 0
    preference :currency,        :string,  default: -> { Viauco::Config[:currency] }

    def self.description
      Viauco.t(:flexible_rate)
    end

    def self.available?(_object)
      true
    end

    def compute(object)
      compute_from_quantity(object.quantity)
    end

    def compute_from_quantity(quantity)
      count = [quantity, preferred_max_items].reject(&:zero?).min

      return BigDecimal(0) if count.zero?

      preferred_first_item + (count - 1) * preferred_additional_item
    end
  end
end
