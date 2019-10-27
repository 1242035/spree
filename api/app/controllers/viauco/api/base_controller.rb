require_dependency 'viauco/api/controller_setup'

module Viauco
  module Api
    class BaseController < ActionController::Base
      protect_from_forgery unless: -> { request.format.json? || request.format.xml? }

      include Viauco::Api::ControllerSetup
      include Viauco::Core::ControllerHelpers::Store
      include Viauco::Core::ControllerHelpers::StrongParameters

      attr_accessor :current_api_user

      before_action :set_content_type
      before_action :load_user
      before_action :authorize_for_order, if: proc { order_token.present? }
      before_action :authenticate_user
      before_action :load_user_roles

      rescue_from ActionController::ParameterMissing, with: :error_during_processing
      rescue_from ActiveRecord::RecordInvalid, with: :error_during_processing
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from CanCan::AccessDenied, with: :unauthorized
      rescue_from Viauco::Core::GatewayError, with: :gateway_error

      helper Viauco::Api::ApiHelpers

      # users should be able to set price when importing orders via api
      def permitted_line_item_attributes
        if @current_user_roles.include?('admin')
          super + [:price, :variant_id, :sku]
        else
          super
        end
      end

      def content_type
        case params[:format]
        when 'json'
          'application/json; charset=utf-8'
        when 'xml'
          'text/xml; charset=utf-8'
        end
      end

      private

      def set_content_type
        headers['Content-Type'] = content_type
      end

      def load_user
        @current_api_user = Viauco.user_class.find_by(viauco_api_key: api_key.to_s)
      end

      def authenticate_user
        return if @current_api_user

        if requires_authentication? && api_key.blank? && order_token.blank?
          must_specify_api_key and return
        elsif order_token.blank? && (requires_authentication? || api_key.present?)
          invalid_api_key and return
        else
          # An anonymous user
          @current_api_user = Viauco.user_class.new
        end
      end

      def invalid_api_key
        render 'viauco/api/errors/invalid_api_key', status: 401
      end

      def must_specify_api_key
        render 'viauco/api/errors/must_specify_api_key', status: 401
      end

      def load_user_roles
        @current_user_roles = @current_api_user ? @current_api_user.viauco_roles.pluck(:name) : []
      end

      def unauthorized
        render 'viauco/api/errors/unauthorized', status: 401 and return
      end

      def error_during_processing(exception)
        Rails.logger.error exception.message
        Rails.logger.error exception.backtrace.join("\n")

        unprocessable_entity(exception.message)
      end

      def unprocessable_entity(message)
        render plain: { exception: message }.to_json, status: 422
      end

      def gateway_error(exception)
        @order.errors.add(:base, exception.message)
        invalid_resource!(@order)
      end

      def requires_authentication?
        Viauco::Api::Config[:requires_authentication]
      end

      def not_found
        render 'viauco/api/errors/not_found', status: 404 and return
      end

      def current_ability
        Viauco::Dependencies.ability_class.constantize.new(current_api_user)
      end

      def invalid_resource!(resource)
        @resource = resource
        render 'viauco/api/errors/invalid_resource', status: 422
      end

      def api_key
        request.headers['X-Viauco-Token'] || params[:token]
      end
      helper_method :api_key

      def order_token
        request.headers['X-Viauco-Order-Token'] || params[:order_token]
      end

      def find_product(id)
        @product = product_scope.friendly.distinct(false).find(id.to_s)
      rescue ActiveRecord::RecordNotFound
        @product = product_scope.find_by(id: id)
        not_found unless @product
      end

      def product_scope
        if @current_user_roles.include?('admin')
          scope = Product.with_deleted.accessible_by(current_ability, :show).includes(*product_includes)

          scope = scope.not_deleted unless params[:show_deleted]
          scope = scope.not_discontinued unless params[:show_discontinued]
        else
          scope = Product.accessible_by(current_ability, :show).active.includes(*product_includes)
        end

        scope
      end

      def variants_associations
        [{ option_values: :option_type }, :default_price, :images]
      end

      def product_includes
        [:option_types, :taxons, product_properties: :property, variants: variants_associations, master: variants_associations]
      end

      def order_id
        params[:order_id] || params[:checkout_id] || params[:order_number]
      end

      def authorize_for_order
        @order = Viauco::Order.find_by(number: order_id)
        authorize! :show, @order, order_token
      end
    end
  end
end
