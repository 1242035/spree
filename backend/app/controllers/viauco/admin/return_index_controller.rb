module Viauco
  module Admin
    class ReturnIndexController < BaseController
      def return_authorizations
        collection(Viauco::ReturnAuthorization)
        respond_with(@collection)
      end

      def customer_returns
        collection(Viauco::CustomerReturn)
        respond_with(@collection)
      end

      private

      def collection(resource)
        return @collection if @collection.present?

        params[:q] ||= {}

        @collection = resource.all
        # @search needs to be defined as this is passed to search_form_for
        @search = @collection.ransack(params[:q])
        per_page = params[:per_page] || Viauco::Config[:admin_customer_returns_per_page]
        @collection = @search.result.order(created_at: :desc).page(params[:page]).per(per_page)
      end
    end
  end
end
