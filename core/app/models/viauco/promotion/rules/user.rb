module Viauco
  class Promotion
    module Rules
      class User < PromotionRule
        belongs_to :user, class_name: "::#{Viauco.user_class}"

        has_many :promotion_rule_users, class_name: 'Viauco::PromotionRuleUser',
                                        foreign_key: :promotion_rule_id,
                                        dependent: :destroy
        has_many :users, through: :promotion_rule_users, class_name: "::#{Viauco.user_class}"

        def applicable?(promotable)
          promotable.is_a?(Viauco::Order)
        end

        def eligible?(order, _options = {})
          users.include?(order.user)
        end

        def user_ids_string
          user_ids.join(',')
        end

        def user_ids_string=(s)
          self.user_ids = s.to_s.split(',').map(&:strip)
        end
      end
    end
  end
end
