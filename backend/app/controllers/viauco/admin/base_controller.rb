module Viauco
  module Admin
    class BaseController < Viauco::BaseController
      helper 'viauco/admin/navigation'
      layout 'viauco/layouts/admin'

      before_action :authorize_admin
      before_action :generate_admin_api_key

      protected

      def action
        params[:action].to_sym
      end

      def authorize_admin
        record = if respond_to?(:model_class, true) && model_class
                   model_class
                 else
                   controller_name.to_sym
                 end
        authorize! :admin, record
        authorize! action, record
      end

      # Need to generate an API key for a user due to some backend actions
      # requiring authentication to the Viauco API
      def generate_admin_api_key
        if (user = try_viauco_current_user) && user.viauco_api_key.blank?
          user.generate_viauco_api_key!
        end
      end

      def flash_message_for(object, event_sym)
        resource_desc  = object.class.model_name.human
        resource_desc += " \"#{object.name}\"" if object.respond_to?(:name) && object.name.present?
        Viauco.t(event_sym, resource: resource_desc)
      end

      def render_js_for_destroy
        render partial: '/viauco/admin/shared/destroy'
      end

      def config_locale
        Viauco::Backend::Config[:locale]
      end

      def can_not_transition_without_customer_info
        unless @order.billing_address.present?
          flash[:notice] = Viauco.t(:fill_in_customer_info)
          redirect_to edit_admin_order_customer_url(@order)
        end
      end
    end
  end
end
