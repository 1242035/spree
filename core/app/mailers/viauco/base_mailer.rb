module Viauco
  class BaseMailer < ActionMailer::Base
    def from_address
      Viauco::Store.current.mail_from_address
    end

    def money(amount, currency = Viauco::Config[:currency])
      Viauco::Money.new(amount, currency: currency).to_s
    end
    helper_method :money

    def frontend_available?
      Viauco::Core::Engine.frontend_available?
    end
    helper_method :frontend_available?

    def mail(headers = {}, &block)
      ensure_default_action_mailer_url_host
      super if Viauco::Config[:send_core_emails]
    end

    private

    # this ensures that ActionMailer::Base.default_url_options[:host] is always set
    # this is only a fail-safe solution if developer didn't set this in environment files
    # http://guides.rubyonrails.org/action_mailer_basics.html#generating-urls-in-action-mailer-views
    def ensure_default_action_mailer_url_host
      ActionMailer::Base.default_url_options ||= {}
      ActionMailer::Base.default_url_options[:host] ||= Viauco::Store.current.url
    end
  end
end
