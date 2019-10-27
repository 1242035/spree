module Viauco
  class PromotionActionLineItem < Viauco::Base
    belongs_to :promotion_action, class_name: 'Viauco::Promotion::Actions::CreateLineItems'
    belongs_to :variant, class_name: 'Viauco::Variant'

    validates :promotion_action, :variant, :quantity, presence: true
    validates :quantity, numericality: { only_integer: true, message: Viauco.t('validation.must_be_int') }
  end
end
