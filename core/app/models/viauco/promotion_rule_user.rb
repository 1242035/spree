module Viauco
  class PromotionRuleUser < Viauco::Base
    belongs_to :promotion_rule, class_name: 'Viauco::PromotionRule'
    belongs_to :user, class_name: Viauco.user_class.to_s

    validates :user, :promotion_rule, presence: true
    validates :user_id, uniqueness: { scope: :promotion_rule_id }, allow_nil: true
  end
end
