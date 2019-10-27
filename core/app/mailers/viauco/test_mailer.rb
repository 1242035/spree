module Viauco
  class TestMailer < BaseMailer
    def test_email(email)
      subject = "#{Viauco::Store.current.name} #{Viauco.t('test_mailer.test_email.subject')}"
      mail(to: email, from: from_address, subject: subject)
    end
  end
end
