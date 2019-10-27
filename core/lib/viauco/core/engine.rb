module Viauco
  module Core
    class Engine < ::Rails::Engine
      Environment = Struct.new(:calculators,
                               :preferences,
                               :dependencies,
                               :payment_methods,
                               :adjusters,
                               :stock_splitters,
                               :promotions,
                               :line_item_comparison_hooks)
      ViaucoCalculators = Struct.new(:shipping_methods, :tax_rates, :promotion_actions_create_adjustments, :promotion_actions_create_item_adjustments)
      PromoEnvironment = Struct.new(:rules, :actions)
      isolate_namespace Viauco
      engine_name 'viauco'

      rake_tasks do
        load File.join(root, 'lib', 'tasks', 'exchanges.rake')
      end

      initializer 'viauco.environment', before: :load_config_initializers do |app|
        app.config.viauco = Environment.new(ViaucoCalculators.new, Viauco::AppConfiguration.new, Viauco::AppDependencies.new)
        Viauco::Config = app.config.viauco.preferences
        Viauco::Dependencies = app.config.viauco.dependencies
      end

      initializer 'viauco.register.calculators' do |app|
        app.config.viauco.calculators.shipping_methods = [
          Viauco::Calculator::Shipping::FlatPercentItemTotal,
          Viauco::Calculator::Shipping::FlatRate,
          Viauco::Calculator::Shipping::FlexiRate,
          Viauco::Calculator::Shipping::PerItem,
          Viauco::Calculator::Shipping::PriceSack
        ]

        app.config.viauco.calculators.tax_rates = [
          Viauco::Calculator::DefaultTax
        ]
      end

      initializer 'viauco.register.stock_splitters', before: :load_config_initializers do |app|
        app.config.viauco.stock_splitters = [
          Viauco::Stock::Splitter::ShippingCategory,
          Viauco::Stock::Splitter::Backordered
        ]
      end

      initializer 'viauco.register.line_item_comparison_hooks', before: :load_config_initializers do |app|
        app.config.viauco.line_item_comparison_hooks = Set.new
      end

      initializer 'viauco.register.payment_methods', after: 'acts_as_list.insert_into_active_record' do |app|
        app.config.viauco.payment_methods = [
          Viauco::Gateway::Bogus,
          Viauco::Gateway::BogusSimple,
          Viauco::PaymentMethod::Check,
          Viauco::PaymentMethod::StoreCredit
        ]
      end

      initializer 'viauco.register.adjustable_adjusters' do |app|
        app.config.viauco.adjusters = [
          Viauco::Adjustable::Adjuster::Promotion,
          Viauco::Adjustable::Adjuster::Tax
        ]
      end

      # We need to define promotions rules here so extensions and existing apps
      # can add their custom classes on their initializer files
      initializer 'viauco.promo.environment' do |app|
        app.config.viauco.promotions = PromoEnvironment.new
        app.config.viauco.promotions.rules = []
      end

      initializer 'viauco.promo.register.promotion.calculators' do |app|
        app.config.viauco.calculators.promotion_actions_create_adjustments = [
          Viauco::Calculator::FlatPercentItemTotal,
          Viauco::Calculator::FlatRate,
          Viauco::Calculator::FlexiRate,
          Viauco::Calculator::TieredPercent,
          Viauco::Calculator::TieredFlatRate
        ]

        app.config.viauco.calculators.promotion_actions_create_item_adjustments = [
          Viauco::Calculator::PercentOnLineItem,
          Viauco::Calculator::FlatRate,
          Viauco::Calculator::FlexiRate
        ]
      end

      # Promotion rules need to be evaluated on after initialize otherwise
      # Viauco.user_class would be nil and users might experience errors related
      # to malformed model associations (Viauco.user_class is only defined on
      # the app initializer)
      config.after_initialize do
        Rails.application.config.viauco.promotions.rules.concat [
          Viauco::Promotion::Rules::ItemTotal,
          Viauco::Promotion::Rules::Product,
          Viauco::Promotion::Rules::User,
          Viauco::Promotion::Rules::FirstOrder,
          Viauco::Promotion::Rules::UserLoggedIn,
          Viauco::Promotion::Rules::OneUsePerUser,
          Viauco::Promotion::Rules::Taxon,
          Viauco::Promotion::Rules::OptionValue,
          Viauco::Promotion::Rules::Country
        ]
      end

      initializer 'viauco.promo.register.promotions.actions' do |app|
        app.config.viauco.promotions.actions = [
          Promotion::Actions::CreateAdjustment,
          Promotion::Actions::CreateItemAdjustments,
          Promotion::Actions::CreateLineItems,
          Promotion::Actions::FreeShipping
        ]
      end

      # filter sensitive information during logging
      initializer 'viauco.params.filter' do |app|
        app.config.filter_parameters += [
          :password,
          :password_confirmation,
          :number,
          :verification_value
        ]
      end

      initializer 'viauco.core.checking_migrations' do
        Migrations.new(config, engine_name).check
      end

      config.to_prepare do
        # Ensure viauco locale paths are present before decorators
        I18n.load_path.unshift(*(Dir.glob(
          File.join(
            File.dirname(__FILE__), '../../../config/locales', '*.{rb,yml}'
          )
        ) - I18n.load_path))

        # Load application's model / class decorators
        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end
    end
  end
end

require 'viauco/core/routes'
require 'viauco/core/components'
