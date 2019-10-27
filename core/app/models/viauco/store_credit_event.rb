module Viauco
  class StoreCreditEvent < Viauco::Base
    acts_as_paranoid

    belongs_to :store_credit
    belongs_to :originator, polymorphic: true

    scope :exposed_events, -> { where.not(action: [Viauco::StoreCredit::ELIGIBLE_ACTION, Viauco::StoreCredit::AUTHORIZE_ACTION]) }
    scope :reverse_chronological, -> { order(created_at: :desc) }

    delegate :currency, to: :store_credit

    def display_amount
      Viauco::Money.new(amount, currency: currency)
    end

    def display_user_total_amount
      Viauco::Money.new(user_total_amount, currency: currency)
    end

    def display_action
      case action
      when Viauco::StoreCredit::CAPTURE_ACTION
        Viauco.t('store_credit.captured')
      when Viauco::StoreCredit::AUTHORIZE_ACTION
        Viauco.t('store_credit.authorized')
      when Viauco::StoreCredit::ALLOCATION_ACTION
        Viauco.t('store_credit.allocated')
      when Viauco::StoreCredit::VOID_ACTION, Viauco::StoreCredit::CREDIT_ACTION
        Viauco.t('store_credit.credit')
      end
    end

    def order
      Viauco::Payment.find_by(response_code: authorization_code).try(:order)
    end
  end
end
