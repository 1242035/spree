require 'rails/all'
require 'active_merchant'
require 'acts_as_list'
require 'awesome_nested_set'
require 'cancan'
require 'friendly_id'
require 'kaminari'
require 'mail'
require 'monetize'
require 'paranoia'
require 'mini_magick'
require 'premailer/rails'
require 'ransack'
require 'responders'
require 'state_machines-activerecord'

# This is required because ActiveModel::Validations#invalid? conflicts with the
# invalid state of a Payment. In the future this should be removed.
StateMachines::Machine.ignore_method_conflicts = true

module Viauco
  mattr_accessor :user_class

  def self.user_class(constantize: true)
    if @@user_class.is_a?(Class)
      raise 'Viauco.user_class MUST be a String or Symbol object, not a Class object.'
    elsif @@user_class.is_a?(String) || @@user_class.is_a?(Symbol)
      constantize ? @@user_class.to_s.constantize : @@user_class.to_s
    end
  end

  def self.admin_path
    Viauco::Config[:admin_path]
  end

  # Used to configure admin_path for Viauco
  #
  # Example:
  #
  # write the following line in `config/initializers/viauco.rb`
  #   Viauco.admin_path = '/custom-path'

  def self.admin_path=(path)
    Viauco::Config[:admin_path] = path
  end

  # Used to configure Viauco.
  #
  # Example:
  #
  #   Viauco.config do |config|
  #     config.track_inventory_levels = false
  #   end
  #
  # This method is defined within the core gem on purpose.
  # Some people may only wish to use the Core part of Viauco.
  def self.config
    yield(Viauco::Config)
  end

  # Used to set dependencies for Viauco.
  #
  # Example:
  #
  #   Viauco.dependencies do |dependency|
  #     dependency.cart_add_item_service = MyCustomAddToCart
  #   end
  #
  # This method is defined within the core gem on purpose.
  # Some people may only wish to use the Core part of Viauco.
  def self.dependencies
    yield(Viauco::Dependencies)
  end

  module Core
    autoload :ProductFilters, 'viauco/core/product_filters'
    autoload :TokenGenerator, 'viauco/core/token_generator'

    class GatewayError < RuntimeError; end
    class DestroyWithOrdersError < StandardError; end
  end
end

require 'viauco/core/version'

require 'viauco/core/number_generator'
require 'viauco/migrations'
require 'viauco/core/engine'

require 'viauco/i18n'
require 'viauco/localized_number'
require 'viauco/money'
require 'viauco/permitted_attributes'
require 'viauco/service_module'
require 'viauco/dependencies_helper'

require 'viauco/core/importer'
require 'viauco/core/query_filters'
require 'viauco/core/product_duplicator'
require 'viauco/core/controller_helpers/auth'
require 'viauco/core/controller_helpers/common'
require 'viauco/core/controller_helpers/order'
require 'viauco/core/controller_helpers/search'
require 'viauco/core/controller_helpers/store'
require 'viauco/core/controller_helpers/strong_parameters'
