require_dependency 'viauco/calculator'

module Viauco
  class Calculator::FlatRate < Calculator
    preference :amount, :decimal, default: 0
    preference :currency, :string, default: -> { Viauco::Config[:currency] }

    def self.description
      Viauco.t(:flat_rate_per_order)
    end

    def compute(object = nil)
      if object && preferred_currency.casecmp(object.currency.upcase).zero?
        preferred_amount
      else
        0
      end
    end
  end
end
