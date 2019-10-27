module Viauco
  class ShipmentMailer < BaseMailer
    def shipped_email(shipment, resend = false)
      @shipment = shipment.respond_to?(:id) ? shipment : Viauco::Shipment.find(shipment)
      subject = (resend ? "[#{Viauco.t(:resend).upcase}] " : '')
      subject += "#{Viauco::Store.current.name} #{Viauco.t('shipment_mailer.shipped_email.subject')} ##{@shipment.order.number}"
      mail(to: @shipment.order.email, from: from_address, subject: subject)
    end
  end
end
