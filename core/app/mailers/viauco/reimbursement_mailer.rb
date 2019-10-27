module Viauco
  class ReimbursementMailer < BaseMailer
    def reimbursement_email(reimbursement, resend = false)
      @reimbursement = reimbursement.respond_to?(:id) ? reimbursement : Viauco::Reimbursement.find(reimbursement)
      subject = (resend ? "[#{Viauco.t(:resend).upcase}] " : '')
      subject += "#{Viauco::Store.current.name} #{Viauco.t('reimbursement_mailer.reimbursement_email.subject')} ##{@reimbursement.order.number}"
      mail(to: @reimbursement.order.email, from: from_address, subject: subject)
    end
  end
end
