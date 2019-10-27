require 'spec_helper'
module Viauco
  describe Viauco::Admin::PromotionRulesHelper, type: :helper do
    it 'does not include existing rules in options' do
      promotion = Viauco::Promotion.new
      promotion.promotion_rules << Viauco::Promotion::Rules::ItemTotal.new

      options = helper.options_for_promotion_rule_types(promotion)
      expect(options).not_to match(/ItemTotal/)
    end
  end
end
