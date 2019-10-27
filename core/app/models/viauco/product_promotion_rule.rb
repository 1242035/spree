module Viauco
  class ProductPromotionRule < Viauco::Base
    belongs_to :product, class_name: 'Viauco::Product'
    belongs_to :promotion_rule, class_name: 'Viauco::PromotionRule'

    validates :product, :promotion_rule, presence: true
    validates :product_id, uniqueness: { scope: :promotion_rule_id }, allow_nil: true
  end
end
