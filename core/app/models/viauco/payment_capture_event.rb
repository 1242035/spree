module Viauco
  class PaymentCaptureEvent < Viauco::Base
    belongs_to :payment, class_name: 'Viauco::Payment'

    def display_amount
      Viauco::Money.new(amount, currency: payment.currency)
    end
  end
end
