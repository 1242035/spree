module Viauco
  class AppDependencies
    include Viauco::DependenciesHelper

    INJECTION_POINTS = [
      :ability_class,
      :cart_create_service, :cart_add_item_service, :cart_remove_item_service,
      :cart_remove_line_item_service, :cart_set_item_quantity_service, :cart_recalculate_service,
      :cart_update_service, :checkout_next_service, :checkout_advance_service, :checkout_update_service,
      :checkout_complete_service, :checkout_add_store_credit_service,
      :checkout_remove_store_credit_service, :checkout_get_shipping_rates_service,
      :coupon_handler, :country_finder, :current_order_finder, :credit_card_finder,
      :completed_order_finder, :order_sorter, :cart_compare_line_items_service, :collection_paginator, :products_sorter,
      :products_finder, :taxon_finder, :line_item_by_variant_finder, :cart_estimate_shipping_rates_service
    ].freeze

    attr_accessor *INJECTION_POINTS

    def initialize
      set_default_ability
      set_default_services
      set_default_finders
    end

    private

    def set_default_ability
      @ability_class = 'Viauco::Ability'
    end

    def set_default_services
      # cart
      @cart_compare_line_items_service = 'Viauco::CompareLineItems'
      @cart_create_service = 'Viauco::Cart::Create'
      @cart_add_item_service = 'Viauco::Cart::AddItem'
      @cart_update_service = 'Viauco::Cart::Update'
      @cart_recalculate_service = 'Viauco::Cart::Recalculate'
      @cart_remove_item_service = 'Viauco::Cart::RemoveItem'
      @cart_remove_line_item_service = 'Viauco::Cart::RemoveLineItem'
      @cart_set_item_quantity_service = 'Viauco::Cart::SetQuantity'
      @cart_estimate_shipping_rates_service = 'Viauco::Cart::EstimateShippingRates'

      # checkout
      @checkout_next_service = 'Viauco::Checkout::Next'
      @checkout_advance_service = 'Viauco::Checkout::Advance'
      @checkout_update_service = 'Viauco::Checkout::Update'
      @checkout_complete_service = 'Viauco::Checkout::Complete'
      @checkout_add_store_credit_service = 'Viauco::Checkout::AddStoreCredit'
      @checkout_remove_store_credit_service = 'Viauco::Checkout::RemoveStoreCredit'
      @checkout_get_shipping_rates_service = 'Viauco::Checkout::GetShippingRates'

      # sorter
      @order_sorter = 'Viauco::Orders::Sort'
      @products_sorter = 'Viauco::Products::Sort'

      # paginator
      @collection_paginator = 'Viauco::Shared::Paginate'

      # coupons
      # TODO: we should split this service into 2 seperate - Add and Remove
      @coupon_handler = 'Viauco::PromotionHandler::Coupon'
    end

    def set_default_finders
      @country_finder = 'Viauco::Countries::Find'
      @current_order_finder = 'Viauco::Orders::FindCurrent'
      @completed_order_finder = 'Viauco::Orders::FindComplete'
      @credit_card_finder = 'Viauco::CreditCards::Find'
      @products_finder = 'Viauco::Products::Find'
      @taxon_finder = 'Viauco::Taxons::Find'
      @line_item_by_variant_finder = 'Viauco::LineItems::FindByVariant'
    end
  end
end
