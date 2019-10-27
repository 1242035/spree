module Viauco
  class StoreController < Viauco::BaseController
    include Viauco::Core::ControllerHelpers::Order

    skip_before_action :set_current_order, only: :cart_link
    skip_before_action :verify_authenticity_token, only: :ensure_cart

    def forbidden
      render 'viauco/shared/forbidden', layout: Viauco::Config[:layout], status: 403
    end

    def unauthorized
      render 'viauco/shared/unauthorized', layout: Viauco::Config[:layout], status: 401
    end

    def cart_link
      render partial: 'viauco/shared/link_to_cart'
      fresh_when(simple_current_order)
    end

    def api_tokens
      render json: {
        order_token: current_order&.token,
        oauth_token: current_oauth_token&.token
      }
    end

    def ensure_cart
      render json: current_order(create_order_if_necessary: true) # force creation of order if doesn't exists
    end

    protected

    def config_locale
      Viauco::Frontend::Config[:locale]
    end
  end
end
