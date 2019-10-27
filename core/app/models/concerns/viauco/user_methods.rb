module Viauco
  module UserMethods
    extend ActiveSupport::Concern

    include Viauco::UserPaymentSource
    include Viauco::UserReporting
    include Viauco::RansackableAttributes

    included do
      # we need to have this callback before any dependent: :destroy associations
      # https://github.com/rails/rails/issues/3458
      before_validation :clone_billing_address, if: :use_billing?
      before_destroy :check_completed_orders
      after_destroy :nullify_approver_id_in_approved_orders

      attr_accessor :use_billing

      has_many :role_users, class_name: 'Viauco::RoleUser', foreign_key: :user_id, dependent: :destroy
      has_many :viauco_roles, through: :role_users, class_name: 'Viauco::Role', source: :role

      has_many :promotion_rule_users, class_name: 'Viauco::PromotionRuleUser', foreign_key: :user_id, dependent: :destroy
      has_many :promotion_rules, through: :promotion_rule_users, class_name: 'Viauco::PromotionRule'

      has_many :orders, foreign_key: :user_id, class_name: 'Viauco::Order'
      has_many :store_credits, foreign_key: :user_id, class_name: 'Viauco::StoreCredit'

      belongs_to :ship_address, class_name: 'Viauco::Address', optional: true
      belongs_to :bill_address, class_name: 'Viauco::Address', optional: true

      self.whitelisted_ransackable_associations = %w[bill_address ship_address]
      self.whitelisted_ransackable_attributes = %w[id email]
    end

    # has_viauco_role? simply needs to return true or false whether a user has a role or not.
    def has_viauco_role?(role_in_question)
      viauco_roles.any? { |role| role.name == role_in_question.to_s }
    end

    def last_incomplete_viauco_order(store)
      orders.where(store: store).incomplete.
        includes(line_items: [variant: [:images, :option_values, :product]]).
        order('created_at DESC').
        first
    end

    def total_available_store_credit
      store_credits.reload.to_a.sum(&:amount_remaining)
    end

    private

    def check_completed_orders
      raise Viauco::Core::DestroyWithOrdersError if orders.complete.present?
    end

    def nullify_approver_id_in_approved_orders
      Viauco::Order.where(approver_id: id).update_all(approver_id: nil)
    end

    def clone_billing_address
      if bill_address && ship_address.nil?
        self.ship_address = bill_address.clone
      else
        ship_address.attributes = bill_address.attributes.except('id', 'updated_at', 'created_at')
      end
      true
    end

    def use_billing?
      use_billing.in?([true, 'true', '1'])
    end
  end
end
