module Viauco
  class OrdersController < Viauco::StoreController
    before_action :check_authorization
    helper 'viauco/products', 'viauco/orders'

    respond_to :html

    before_action :assign_order_with_lock, only: :update

    def show
      @order = Order.includes(line_items: [variant: [:option_values, :images, :product]], bill_address: :state, ship_address: :state).find_by!(number: params[:id])
    end

    def update
      @variant = Viauco::Variant.find(params[:variant_id]) if params[:variant_id]
      if Cart::Update.call(order: @order, params: order_params).success?
        respond_with(@order) do |format|
          format.html do
            if params.key?(:checkout)
              @order.next if @order.cart?
              redirect_to checkout_state_path(@order.checkout_steps.first)
            else
              redirect_to cart_path
            end
          end
        end
      else
        respond_with(@order)
      end
    end

    # Shows the current incomplete order from the session
    def edit
      @order = current_order || Order.incomplete.
               includes(line_items: [variant: [:images, :option_values, :product]]).
               find_or_initialize_by(token: cookies.signed[:token])
      associate_user
    end

    def empty
      current_order.try(:empty!)

      redirect_to viauco.cart_path
    end

    private

    def accurate_title
      if @order&.completed?
        Viauco.t(:order_number, number: @order.number)
      else
        Viauco.t(:shopping_cart)
      end
    end

    def check_authorization
      order = Viauco::Order.find_by(number: params[:id]) if params[:id].present?
      order ||= current_order

      if order && action_name.to_sym == :show
        authorize! :show, order, cookies.signed[:token]
      elsif order
        authorize! :edit, order, cookies.signed[:token]
      else
        authorize! :create, Viauco::Order
      end
    end

    def order_params
      if params[:order]
        params[:order].permit(*permitted_order_attributes)
      else
        {}
      end
    end

    def assign_order_with_lock
      @order = current_order(lock: true)
      unless @order
        flash[:error] = Viauco.t(:order_not_found)
        redirect_to root_path and return
      end
    end

    def cart_add_item_service
      Viauco::Dependencies.cart_add_item_service.constantize
    end
  end
end
